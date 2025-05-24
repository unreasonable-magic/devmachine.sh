#!/usr/bin/env bash

source "$DEVMACHINE_PATH/lib/devmachine.sh"

shell_name="$1"
shift

# Create a temporary (bash/zsh)rc file and write our env to it
temp_dir="$(mktemp -d)"
rc_file_name=".${shell_name}rc"
temp_rc_file="${temp_dir}/$rc_file_name"

shell::rcfile "$shell_name" >> "$temp_rc_file"

cat >> "$temp_rc_file" << EOF
devmachine_config=\$(devmachine +config)

cat << IOF
    _                       _    _
 __| |_____ ___ __  __ _ __| |_ (_)_ _  ___
/ _\\\` / -_) V / '  \/ _\\\` / _| ' \| | ' \/ -_)
\__,_\___|\_/|_|_|_\__,_\__|_||_|_|_||_\___|

\$devmachine_config

Functions:
  reload # reload current shell
  editrc # load the rc file in \\\$EDITOR

IOF

reload() { exec "\$SHELL"; }
editrc() { "\$EDITOR" "\$HOME/$rc_file_name"; }
EOF


if [[ "$1" == "rcfile" ]]; then
  cat "$temp_rc_file"
  exit
fi

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
