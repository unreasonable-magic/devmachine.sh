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

os::softdelete() {
  ui::logfunc "os::softdelete" "$@"

  local path="$1"

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

  local source_file="$1"
  local target_link="$2"

  # If the file we're trying to link doesn't exist, then something the user has
  # done is very wrong, so we should error out and stop everything
  if ! stdlib::test::exists "$source_file"; then
    stdlib::error::fatal "$source_file no exist"
  fi

  target_dir="$(dirname "$target_link")"

  if ! stdlib::test::isdir "$target_dir"; then
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
