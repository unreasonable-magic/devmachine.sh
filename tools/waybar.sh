#!/usr/bin/env devtool

case "$1" in

  setup)
    os::install "waybar"
    ;;

  --check-eligible)
    which pacman > /dev/null &&
      pacman -Si waybar &> /dev/null
    ;;

  --check-installed)
    command -v waybar &> /dev/null && echo yes
    ;;

  --check-version)
    waybar --version | cut -d ' ' -f 2
    ;;

esac
