#!/usr/bin/env devtool

case "$1" in

  setup)
    os::install "docker"
    ;;

  --check-installed)
    command -v docker &> /dev/null && echo yes
    ;;

  --check-version)
    # eg: Docker version 25.0.5, build 5dc9bcc
    docker --version | head -1 | cut -d ' ' -f 3 | sed -e 's/[^0-9\.]//g'
    ;;

esac
