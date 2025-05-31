#!/usr/bin/env bash

shell_name="${1:-$SHELL}"
shift

# Create a temporary (bash/zsh)rc file and write our env to it
temp_dir="$(mktemp -d /tmp/devmachine-XXX)"
rc_file_name=".${shell_name}rc"
temp_rc_file="${temp_dir}/$rc_file_name"

cat >> "$temp_rc_file" << EOF
HOME="$temp_dir"
EOF

shell::rcfile "$shell_name" >> "$temp_rc_file"

cat >> "$temp_rc_file" << EOF
devmachine_config=\$(devmachine +config)

cat << 'IOF'
$(ui::banner::small)

IOF

cat << IOF
\$devmachine_config

$(ui::logsection "Functions")
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
