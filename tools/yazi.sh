#!/usr/bin/env devtool

case "$1" in

  setup)
    os::install "yazi"
    ;;

  --check-installed)
    command -v yazi &> /dev/null && echo yes
    ;;

  --check-version)
    yazi --version | cut -d ' ' -f 2
    ;;

esac
