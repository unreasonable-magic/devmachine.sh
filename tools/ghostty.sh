#!/usr/bin/env devtool

GHOSTTY_CONFIG_PATH="${GHOSTTY_CONFIG_PATH:-$HOME/.config/ghostty}"

case "$1" in

  logo)
    stdlib::image::print "$DEVMACHINE_PATH/tools/ghostty/logo.png" 17 10
    ;;

  setup)
    os::install "ghostty"

    # https://github.com/ghostty-org/ghostty/pull/1102/files
    os::sh touch "$HOME/.hushlogin"

    os::linkfile "$DEVMACHINE_PATH/tools/ghostty/config" "$GHOSTTY_CONFIG_PATH/config"
    ;;

  config)
    "$EDITOR" "$GHOSTTY_CONFIG_PATH/config"
    ;;

  --check-installed)
    command -v ghostty &> /dev/null && echo yes
    ;;

  --check-version)
    ghostty --version | head -n 1 | sed 's/Ghostty //'
    ;;

esac
