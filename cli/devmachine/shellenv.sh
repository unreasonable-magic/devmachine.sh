#!/usr/bin/env bash

shell_cmd="$1"
if [[ "$shell_cmd" == "" ]]; then exit; fi

shell_name="${shell_cmd##*/}"

if [[ "$shell_name" == "" ]]; then
  echo "invalid shell: ${shell_cmd}"
  exit
fi

# accessing $SHELL seems hit or miss sometimes, so
# just always shove it in
printf "export SHELL='%s'\n" $shell_name

# make sure our own bin is part of PATH
printf 'PATH="$PATH:%s"\n' "$DEVMACHINE_PATH/bin"

os="$(uname -s)"
if [[ "$os" == "Darwin" ]]; then
  cat "$DEVMACHINE_PATH/os/darwin/env.sh"
fi

echo '__devmachine_init_start="$(date +%s%N)"'

cat "$DEVMACHINE_PATH/shell/env.sh"
cat "$DEVMACHINE_PATH/shell/$shell_name/env.$shell_name"

echo '__devmachine_init_end="$(date +%s%N)"'
echo 'DEVMACHINE_INIT_RUNTIME="$((__devmachine_init_end - __devmachine_init_start))"'
cat "$DEVMACHINE_PATH/shell/$shell_name/motd.$shell_name"
