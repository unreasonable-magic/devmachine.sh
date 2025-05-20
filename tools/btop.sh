#!/usr/bin/env devtool

case "$1" in

  setup)
    devmachine::install "btop"
    ;;

  --check-installed)
    command -v btop &> /dev/null && echo yes
    ;;

  --check-version)
    btop --version
    ;;

esac
