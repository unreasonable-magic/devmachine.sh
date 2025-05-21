#!/usr/bin/env devtool

case "$1" in

  setup)
    os::install "git-delta"
    ;;

  --check-installed)
    command -v delta &> /dev/null && echo yes
    ;;

  --check-version)
    delta --version | cut -d ' ' -f 2
    ;;

esac
