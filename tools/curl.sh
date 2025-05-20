#!/usr/bin/env devtool

case "$1" in

  setup)
    os::install "curl"
    ;;

  --check-installed)
    command -v curl &> /dev/null && echo yes
    ;;

  --check-version)
    curl --version | head -1 | cut -d ' ' -f 2
    ;;

esac
