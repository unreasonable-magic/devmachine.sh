#!/usr/bin/env devtool

case "$1" in

  setup)
    devmachine::install "kitty"
    ;;

  --check-installed)
    command -v kitty &> /dev/null && echo yes
    ;;

  --check-version)
    kitty --version
    ;;

esac
