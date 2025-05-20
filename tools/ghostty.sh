#!/usr/bin/env devtool

GHOSTTY_CONFIG_PATH="${GHOSTTY_CONFIG_PATH:-$HOME/.config/ghostty}"

case "$1" in

  logo)
    logo_path="$DEVMACHINE_PATH/tools/ghostty/logo.png"
    encoded=$(echo "$logo_path" | tr -d '\n' | base64 | tr -d '=' | tr -d '\n')

    printf "\n\e_Ga=T,q=2,f=100,t=f,c=17,r=10;%s\e\\ \n\n" "$encoded"
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
