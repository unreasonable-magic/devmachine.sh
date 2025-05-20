#!/usr/bin/env bash

devmachine::sh() {
  echo "$@"
  eval "$@"
}

devmachine::install() {
  export HOMEBREW_NO_ENV_HINTS=true
  brew install "$1"
}

devmachine::commandtest() {
  if [[ -x "$(command -v $1)" ]]; then
    echo "yes"
  else
    exit 1
  fi
}

devmachine::linkfile() {
  local source_file="$1"
  local target_link="$2"

  echo "  linking ${source_file} to ${target_link}"

  if [[ ! -e  "$source_file" ]]; then

    "$source_file no exist"
    exit 1

  fi

  target_dir="$(dirname "$target_link")"

  if [[ ! -d "$target_dir" ]]; then
    mkdir -p "$target_dir"
  fi

  if [[ -e "$target_link" ]]; then
    local file_type="$(stat -f "%HT" "$target_link")"
    local symbolic_link_to="$(stat -f "%Y" "$target_link")"

    if [[ "$file_type" == "Symbolic Link" ]]; then
      if [[ "$source_file" == "$symbolic_link_to" ]]; then
        echo "files all linked, all good"
        return
      fi
    elif [[ "$file_type" == "Regular File" ]]; then

      if [[ $(sha256 -q "$source_file") != $(sha256 -q "$target_link") ]]; then
        # echo "files are diff"
        #diff "$source_file" "$target_link"
        delta -s "$source_file" "$target_link"
      else
        echo "file exists, but they're the same, so gonna link it"
        ln -fs "$source_file" "$target_link"
      fi

    else
      echo "dunno how ot handle $file_type"
      exit 1
    fi
  else

    echo "target no exist, linking"
    ln -fs "$source_file" "$target_link"

  fi
}
