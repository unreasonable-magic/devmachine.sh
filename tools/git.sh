#!/usr/bin/env devtool

GIT_CONFIG_PATH="${GIT_CONFIG_PATH:-$HOME/.config/git}"

case "$1" in

  setup)
    os::install "git"
    os::linkfile "$DEVMACHINE_PATH/tools/git/config" "$GIT_CONFIG_PATH/config"
    ;;

  config)
    "$EDITOR" "$GIT_CONFIG_PATH/config"
    ;;


  --check-installed)
    command -v git &> /dev/null && echo yes
    ;;

  --check-version)
    git --version | cut -d ' ' -f 3
    ;;

esac
