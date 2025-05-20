#!/usr/bin/env devtool

case "$1" in

  setup)
    devmachine::install "docker"
    ;;

  --check-installed)
    command -v docker &> /dev/null && echo yes
    ;;

  --check-version)
    docker --version | head -1 | cut -d ' ' -f 3
    ;;

esac
