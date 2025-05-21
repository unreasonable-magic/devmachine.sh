#!/usr/bin/env bash

source "$DEVMACHINE_PATH/lib/devmachine.sh"

shell_cmd="$1"
if [[ "$shell_cmd" == "" ]]; then exit; fi

shell_name="${shell_cmd##*/}"

if [[ "$shell_name" == "" ]]; then
  echo "invalid shell: ${shell_cmd}"
  exit
fi

os="$(uname -s)"
if [[ "$os" == "Darwin" ]]; then
  cat "$DEVMACHINE_PATH/os/darwin.sh"
elif [[ "$os" == "Linux" ]]; then
  cat "$DEVMACHINE_PATH/os/linux.sh"
fi

# zsh_date_load=""
# date_cmd=""
# if [[ "$shell_name" == "zsh" ]]; then
#   date_cmd="\"\${\${EPOCHREALTIME/[^0-9]/}%???}\""
#   zsh_date_load="zmodload zsh/datetime"
# elif [[ "$shell_name" == "bash" ]]; then
#   date_cmd="\$(date +%s%N)"
# fi

cat <<- EOF
export SHELL='$shell_name'

PATH="\$PATH:$DEVMACHINE_PATH/bin"

# \$zsh_date_load

# __devmachine_init_start=\$date_cmd

cache_path="\$XDG_CACHE_HOME/devmachine"
shellenv_cache_path="\$cache_path/shellenv_$shell_name.sh"

if [[ -e "\$shellenv_cache_path" ]]; then
  source "\$shellenv_cache_path"
else
  mkdir -p "\$cache_path"

  tools=""

  # Loop through each tool, check if it's installed, and add it to
  # our running tools buffer
  for tool_name in "\${DEVMACHINE_PATH}"/tools/*.sh; do
    tool_name="\${tool_name##*/}"
    tool_name="\${tool_name/.sh/}"

    check=\$(\$DEVMACHINE_PATH/bin/devtool "\$tool_name" --check-installed)
    if [[ "\$check" == "yes" ]]; then
      priority="\$(devtool "\$tool_name" --check-priority)"
      if [[ "\$priority" == "high" ]]; then
        priority="100"
      fi
      tools+="\${priority:-0}\t\$tool_name\n"
    fi
  done

  # Now we have a tool list like:
  #
  #       foo
  #   100 bar
  #       bag
  #
  # We want to sort it based on priority so the imporant stuff
  # gets added first to shellenv
  tools="\$(echo -e "\$tools" | sort -g -r)"

  while IFS=$'\n' read -r line; do
    tool_name="\$(echo "\$line" | cut -d \$'\\t' -f 2)"
    shellenv="\$(devtool "\$tool_name" shellenv $shell_name)"
    eval "\$shellenv"
    echo "###### \$ devtool \$tool_name shellenv $shell_name ######\n" >> "\$shellenv_cache_path"
    echo -E "\$shellenv" >> "\$shellenv_cache_path"
  done <<< "\$tools"
fi

# __devmachine_init_end=\$date_cmd
# export DEVMACHINE_INIT_RUNTIME="\$((__devmachine_init_end - __devmachine_init_start))"

devtool $shell_name motd
EOF
