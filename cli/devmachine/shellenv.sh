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
  cat "$DEVMACHINE_PATH/os/darwin.sh"
fi

echo '__devmachine_init_start="$(date +%s%N)"'

cat <<- EOF
cache_path="$XDG_CACHE_HOME/devmachine"
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
EOF

echo '__devmachine_init_end="$(date +%s%N)"'
echo 'export DEVMACHINE_INIT_RUNTIME="$((__devmachine_init_end - __devmachine_init_start))"'

echo "devtool $shell_name motd"
