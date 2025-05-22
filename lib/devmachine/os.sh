#!/usr/bin/env bash

os::sh() {
  echo "$@"
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
  export HOMEBREW_NO_INSTALL_UPGRADE=true
  export HOMEBREW_NO_ENV_HINTS=true
  brew install "$1" -q
}

os::install::pacman() {
  sudo pacman --sync --noconfirm --needed "$1"
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
    timestamp="$(date +%Y%m%d%H%M%S)"
    new_path="$path.$timestamp.devmachinebackup"

    mv "$path" "$new_path" &&
      echo "moved $path to $new_path"
  fi
}

os::download() {
  local url="$1"
  local path="$1"

  curl -fLo "$path" --silent --create-dirs "$url"
}

# return the full path to the passed
# file, following all symlinks along the way
# if readlink -e . >/dev/null 2>&1; then
#   os::normalizepath() {
#     readlink -e "$(realpath $1)"
#   }
# else
#   # Simplified version of https://stackoverflow.com/a/33266819
#   os::normalizepath() {
#     local target="$1"
#     local fname
#
#     while :; do
#       cd "$(dirname -- "$target")"
#       fname="$(basename -- "$target")"
#
#       if [[ -L "$target" ]]; then
#         target="$(readlink "$fname")"
#       else
#         break
#       fi
#     done
#     local targetDir="$(pwd -P)" # Get canonical dir. path
#
#     case "$fname" in
#       .)
#         printf '%s\n' "${targetDir%/}"
#         ;;
#       ..)
#         printf '%s\n' "$(dirname -- "${targetDir}")"
#         ;;
#       *)
#         printf '%s\n' "${targetDir%/}/$fname"
#         ;;
#     esac
#   }
# fi

os::linkfile() {
  ui::logfunc "os::linkfile" "$@"

  local source_file="$1"
  local target_link="$2"

  if ! stdlib::test::exists "$source_file"; then
    stdlib::error::fatal "$source_file no exist"
  fi

  target_dir="$(dirname "$target_link")"

  if ! stdlib::test::isdir "$target_dir"; then
    mkdir -p "$target_dir"
  fi

  if stdlib::test::exists "$target_link"; then
    if [[ "$(realpath $source_file)" == "$(realpath $target_link)" ]]; then
      return
    else
      os::softdelete "$target_link"
    fi
  fi

  ln -fs "$source_file" "$target_link"
}
