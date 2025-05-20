#!/usr/bin/env devtool

case "$1" in

  setup)
    os::install "ripgrep"
    ;;

  --check-installed)
    command -v rg &> /dev/null && echo yes
    ;;

  --check-version)
    rg --version | cut -d ' ' -f 2
    ;;

esac
