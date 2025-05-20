#!/usr/bin/env devtool

case "$1" in

  setup)
    devmachine::install "fastfetch"
    ;;

  --check-installed)
    command -v fastfetch &> /dev/null && echo yes
    ;;

  --check-version)
    fastfetch --version | cut -d ' ' -f 2
    ;;

esac
