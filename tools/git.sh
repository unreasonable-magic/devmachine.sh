#!/usr/bin/env devtool

GIT_CONFIG_PATH="${GIT_CONFIG_PATH:-$HOME/.config/git}"

case "$1" in

  setup)
    os::install "git"
    os::linkfile "$DEVMACHINE_PATH/tools/git/config" "$GIT_CONFIG_PATH/config"
    os::linkfile "$DEVMACHINE_PATH/tools/git/ignore" "$GIT_CONFIG_PATH/ignore"
    ;;

  edit-config)
    "$EDITOR" "$GIT_CONFIG_PATH/config"
    ;;

  edit-ignore)
    "$EDITOR" "$GIT_CONFIG_PATH/ignore"
    ;;

  --check-installed)
    command -v git &> /dev/null && echo yes
    ;;

  --check-version)
    git --version | cut -d ' ' -f 3
    ;;

esac
