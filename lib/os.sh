#!/usr/bin/env bash

os::sh() {
  echo "$@"
  eval "$@"
}

os::install() {
  local os="$(uname -s)"
  if [[ "$os" == "Linux" ]]; then
    sudo pacman --sync --noconfirm --needed $1
  else
    export HOMEBREW_NO_ENV_HINTS=true
    brew install "$1"
  fi
}

os::softdelete() {
  local path="$1"

  if [[ -e "$path" ]]; then
    timestamp="$(date +%Y%m%d%H%M%S)"
    new_path="$path.$timestamp.devmachinebackup"

    mv "$path" "$new_path" &&
      echo "moved $path to $new_path"
  fi
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

test::exists() {
  [ -e "$1" ]
}

os::linkfile() {
  local source_file="$1"
  local target_link="$2"

  if [[ ! -e  "$source_file" ]]; then
    stdlib::error::fatal "$source_file no exist"
  fi

  target_dir="$(dirname "$target_link")"

  if [[ ! -d "$target_dir" ]]; then
    mkdir -p "$target_dir"
  fi

  if test::exists "$target_link"; then
    if [[ "$(realpath $source_file)" == "$(realpath $target_link)" ]]; then
      return
    else
      os::softdelete "$target_link"
    fi
  fi

  echo "linking ${source_file} to ${target_link}"
  ln -fs "$source_file" "$target_link"
}
