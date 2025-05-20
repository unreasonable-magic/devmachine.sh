#!/usr/bin/env bash

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

  declare -a installed_tools

  for t in "\${DEVMACHINE_PATH}"/tools/*.sh; do
    t="\${t##*/}"
    t="\${t/.sh/}"
    check=\$(\$DEVMACHINE_PATH/bin/devtool "\$t" --check-installed)
    if [[ "\$check" == "yes" ]]; then
      installed_tools+=("\$t")
    fi
  done

  for t in \${installed_tools[@]}; do
    shellenv="\$(devtool "\$t" shellenv.priority $shell_name)"
    eval "\$shellenv"
    echo -E "\$shellenv" >> "\$shellenv_cache_path"
  done

  for t in \${installed_tools[@]}; do
    shellenv="\$(devtool "\$t" shellenv $shell_name)"
    eval "\$shellenv"
    echo -E "\$shellenv" >> "\$shellenv_cache_path"
  done
fi

# __devmachine_init_end=\$date_cmd
# export DEVMACHINE_INIT_RUNTIME="\$((__devmachine_init_end - __devmachine_init_start))"

devtool $shell_name motd
EOF
