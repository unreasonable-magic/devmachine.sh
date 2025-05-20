#!/usr/bin/env devtool

case "$1" in

  setup)
    os::install "zoxide"
    ;;

  shellenv)
    zoxide init "$SHELL" --cmd "j"
    ;;

  --check-installed)
    command -v zoxide &> /dev/null && echo yes
    ;;

  --check-version)
    zoxide --version | cut -d ' ' -f 2
    ;;

esac
