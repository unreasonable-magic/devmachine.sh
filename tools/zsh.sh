#!/usr/bin/env devtool

case "$1" in

  setup)
    devmachine::install "zsh"
    ;;

  make-default)
    zsh_path=$(which zsh)
    grep -q "$zsh_path" "/etc/shells" ||
      sudo sh -c "echo $zsh_path >> /etc/shells"
    chsh -s "$zsh_path"
    ;;

  shellenv)
    cat "$DEVMACHINE_PATH/tools/zsh/shellenv.zsh"
    ;;

  motd)
    source "$DEVMACHINE_PATH/tools/zsh/motd.zsh"
    ;;

  --check-installed)
    command -v zsh &> /dev/null && echo yes
    ;;

  --check-version)
    zsh --version | cut -d ' ' -f 2
    ;;

esac
