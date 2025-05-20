#!/usr/bin/env devtool

case "$1" in

  --check-installed)
    command -v irb &> /dev/null && echo yes
    ;;

  --check-version)
    irb --version | cut -d ' ' -f 2
    ;;

esac
