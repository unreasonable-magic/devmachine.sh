#!/usr/bin/env bash

source "$DEVMACHINE_PATH/lib/devmachine.sh"

shell_name="$1"
shift

# Create a temporary (bash/zsh)rc file and write our env to it
temp_dir="$(mktemp -d)"
temp_rc_file="${temp_dir}/.${shell_name}rc"

shell::rcfile "$shell_name" >> "$temp_rc_file"
if [[ "$1" == "--debug" ]]; then
  echo "cat \"$temp_rc_file\"" >> "$temp_rc_file"
fi

# Start a shell using our temp rc file
case $shell_name in
  bash)
    exec bash --rcfile "$temp_rc_file"
    ;;
  zsh)
    export ZDOTDIR="$temp_dir"
    chmod +x "$temp_rc_file"
    exec zsh
    ;;
  *)
    stdlib::error::fatal "unsupported shell $shell_name"
    ;;
esac
