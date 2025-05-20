#!/usr/bin/env devtool

case "$1" in

  setup)
    devmachine::install "ripgrep"
    ;;

  --check-installed)
    command -v ripgrep &> /dev/null && echo yes
    ;;

  --check-version)
    ripgrep --version | cut -d ' ' -f 2
    ;;

esac
