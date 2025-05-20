#!/usr/bin/env devtool

case "$1" in

  setup)
    os::install "kitty"
    ;;

  --check-installed)
    command -v kitty &> /dev/null && echo yes
    ;;

  --check-version)
    kitty --version
    ;;

esac
