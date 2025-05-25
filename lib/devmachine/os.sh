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
  local url="$1"
  local path="$1"

  curl -fLo "$path" --silent --create-dirs "$url"
}

os::linkfile() {
  ui::logfunc "os::linkfile" "$@"

  local source_file="$(os::expandpath $1)"
  local target_link="$(os::expandpath $2)"

  # If the file we're trying to link doesn't exist, then something the user has
  # done is very wrong, so we should error out and stop everything
  if ! stdlib::test::exists "$source_file"; then
    stdlib::error::fatal "$source_file no exist"
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
