#!/usr/bin/env devtool

LSD_CONFIG_PATH="${LSD_CONFIG_PATH:-$HOME/.config/lsd}"

case "$1" in

  setup)
    os::install "lsd"
    os::linkfile "$DEVMACHINE_PATH/tools/lsd/config.yaml" "$LSD_CONFIG_PATH/config.yaml"
    ;;

  edit-config)
    "$EDITOR" "$LSD_CONFIG_PATH/config.yaml"
    ;;

  shellenv)
    echo 'alias ls="lsd"'
    ;;

  --check-installed)
    command -v lsd &> /dev/null && echo yes
    ;;

  --check-version)
    lsd --version | cut -d ' ' -f 2
    ;;


esac
