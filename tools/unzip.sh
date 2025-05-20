#!/usr/bin/env devtool

case "$1" in

  setup)
    os::install "unzip"
    ;;

  --check-installed)
    command -v unzip &> /dev/null && echo yes
    ;;

  --check-version)
    unzip -v |
      head -n 1 |
      cut -d ' ' -f 2
    ;;

esac
