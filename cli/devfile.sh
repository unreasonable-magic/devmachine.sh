#!/usr/bin/env bash

tool_path="$1"
tool_name="$(basename -s ".sh" "$tool_path")"

# This peeks into the tool file and look for all the
# case definitions, i.e. "setup)" "--check-installed" etc.
#
# It then strips the leading whitespace, as well as the trailing ")"
discovered_commands=$(
  cat "$tool_path" |
    grep --extended-regexp --ignore-case '^\s*[a-z\.\-]+)' |
    sed -E "s/^ *//g" |
    sed -E "s/\)$//g"
)

# Turn the discovered commands into an array
declare -a commands=()
for cmd in $discovered_commands; do
  if [[ "$cmd" == "logo" ]]; then
    continue
  fi

  commands+=("$cmd")
done

source "$tool_path" "logo"

declare -i idx=1
for cmd in ${commands[@]}; do
  printf "%s) \e[2mdevmachine %s\e[0m %s\n" "$idx" "$tool_name" "$cmd"
  idx+=1
done

echo
read -p "Enter 1-$(($idx - 1)) (or blank to edit $tool_name.sh): " -r input
echo

if [[ "$input" == "" ]]; then
  "$EDITOR" "${DEVFILES_PATH}/$tool_name.sh"
else
  chosen="${commands[$(($input - 1))]}"
  ui::logsh "devmachine" "$devfile" "$chosen"
  "$DEVMACHINE_PATH/bin/devmachine" "$tool_path" "$chosen"
fi
