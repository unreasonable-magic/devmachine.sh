#!/usr/bin/env devtool

case "$1" in

  setup)
    os::install "btop"
    ;;

  --check-installed)
    command -v btop &> /dev/null && echo yes
    ;;

  --check-version)
    btop --version
    ;;

esac
