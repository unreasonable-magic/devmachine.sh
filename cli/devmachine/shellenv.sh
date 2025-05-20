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

cat <<- EOF
export SHELL='$shell_name'

PATH="\$PATH:$DEVMACHINE_PATH/bin"

__devmachine_init_start="\$(date +%s%N)"

cache_path="\$XDG_CACHE_HOME/devmachine"
shellenv_cache_path="\$cache_path/shellenv_$shell_name.sh"

if [[ -e "\$shellenv_cache_path" ]]; then
  source "\$shellenv_cache_path"
else
  mkdir -p "\$cache_path"

  tools=("homebrew" "mise" "vim" "lsd" "bat" "less" "zoxide" "$shell_name")

  for t in \${tools[@]}; do
    shellenv="\$(devtool "\$t" shellenv $shell_name)"
    eval "\$shellenv"
    echo -E "\$shellenv" >> "\$shellenv_cache_path"
  done
fi

__devmachine_init_end="\$(date +%s%N)"
export DEVMACHINE_INIT_RUNTIME="\$((__devmachine_init_end - __devmachine_init_start))"

devtool $shell_name motd
EOF
