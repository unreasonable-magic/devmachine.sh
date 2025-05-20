#!/usr/bin/env devtool

case "$1" in

  setup)
    os::install "fd"
    ;;

  --check-installed)
    command -v fd &> /dev/null && echo yes
    ;;

  --check-version)
    fd --version | cut -d ' ' -f 2
    ;;

esac
