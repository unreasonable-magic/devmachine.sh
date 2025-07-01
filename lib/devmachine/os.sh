#!/usr/bin/env bash

os::sh() {
  ui::logsh "$@"
  eval "$@"
}

os::install::tool() {
  local os="$(uname -s)"
  if [[ "$os" == "Linux" ]]; then
    echo "pacman"
  else
    echo "brew"
  fi
}

os::install::brew() {
  os::sh export HOMEBREW_NO_AUTO_UPDATE=true
  os::sh export HOMEBREW_NO_INSTALL_UPGRADE=true
  os::sh export HOMEBREW_NO_ENV_HINTS=true
  os::sh brew install "$1" -q
}

os::install::pacman() {
  os::sh sudo pacman --sync --noconfirm --needed "$1"
}

os::install() {
  ui::logfunc "os::install" "$@"

  case "$(os::install::tool)" in
    pacman)
      os::install::pacman "$@"
      ;;
    brew)
      os::install::brew "$@"
      ;;
  esac
}

os::installcheck() {
  case "$(os::install::tool)" in
    pacman)
      pacman -Q "$1" &> /dev/null
      ;;
    brew)
      brew list "$1" &> /dev/null
      ;;
  esac
}

# This function takes a path and returns what it's full absolute version would
# be. So ~/foo becomes /Users/name/foo, and ./blah becomes "$(PWD)/blah".  We
# could use realpath mostly for this, but that errors out if the path doesn't
# exist, which is kinda annoying to deal with, so this is just a slightly safer
# way of doing it without the headache of errors.
os::expandpath() {
  local path="$1"
  local first_char="${path:0:1}"

  if [[ "$first_char" != "/" ]]; then
    if [[ "$first_char" == "~" ]]; then
      path="${HOME}${path:1}"
    else
      if [[ "$first_char" == "." ]]; then
        path="$(pwd)/${path::1}"
      else
        path="$(pwd)/$path"
      fi
    fi
  fi

  echo "$path"
}

os::softdelete() {
  ui::logfunc "os::softdelete" "$@"

  local path="$(os::expandpath "$1")"

  if stdlib::test::exists "$path"; then
    new_path="$path.$(date +%Y%m%d%H%M%S).backup"

    os::sh mv "$path" "$new_path"
  fi
}

os::download() {
  ui::logfunc "os::download" "$@"

  local url="$1"
  local destination="${2:-.}"

  local host=$(urlparse "$url" --host)
  if [[ "$host" == "github.com" ]]; then
    local path=$(urlparse "$url" --path)
    if [[ "$path" == *"releases/latest" ]]; then
      # local org_and_repo="${path/\/releases\/latest/}"
      local latest_release_url=$(urljoin "https://api.github.com/repos/" "$path")
      latest_release_json=$(curl -s "$latest_release_url")

      local asset_search_pattern
      asset_search_pattern=$(urlparse "$url" --fragment)

      if [[ "$asset_search_pattern" == "" ]]; then
        asset_search_pattern="$(uname -ms)"
        asset_search_pattern=$(stdlib::string::underscore "${asset_search_pattern}")
        asset_search_pattern=$(stdlib::string::downcase "${asset_search_pattern}")
        ui::loginfo "no asset search anchor was passed, guessing with ${asset_search_pattern}"
      fi

      url=$(
        echo -E $latest_release_json |
          jq --raw-output --arg pattern "$asset_search_pattern" '.assets[] | select(.name | test($pattern; "i")) | .browser_download_url'
        )

        ui::loginfo "rewrote download url to %s" "$url"
      else
        stdlib::error::fatal "not sure how to download this %s" "$url"
    fi
  fi

  curl -fLo "$destination" --create-dirs "$url"
}

os::linkfile() {
  ui::logfunc "os::linkfile" "$@"

  local source_file="$(os::expandpath $1)"
  local target_link="$(os::expandpath $2)"

  # If the file we're trying to link doesn't exist, then something the user has
  # done is very wrong, so we should error out and stop everything
  if ! stdlib::test::exists "$source_file"; then
    stdlib::error::fatal "source file $source_file no exist"
  fi

  target_dir="$(dirname "$target_link")"

  if ! stdlib::test::is_dir "$target_dir"; then
    os::sh mkdir -p "$target_dir"
  fi

  if stdlib::test::exists "$target_link"; then
    if [[ "$(realpath $source_file)" == "$(realpath $target_link)" ]]; then
      return
    else
      os::softdelete "$target_link"
    fi
  fi

  os::sh ln -fs "$source_file" "$target_link"
}
