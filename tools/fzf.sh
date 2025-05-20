#!/usr/bin/env devtool

case "$1" in

  setup)
    devmachine::install "fzf"
    ;;

  shellenv)
    eval "fzf --$SHELL"
    ;;

  --check-installed)
    command -v fzf &> /dev/null && echo yes
    ;;

  --check-version)
    fzf --version
    ;;

esac
