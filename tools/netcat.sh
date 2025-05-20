#!/usr/bin/env devtool

case "$1" in

  setup)
    os::install "netcat"
    ;;

  --check-installed)
    command -v netcat &> /dev/null && echo yes
    ;;

  --check-version)
    netcat --version
    ;;

esac
