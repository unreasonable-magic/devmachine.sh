#!/usr/bin/env devtool

case "$1" in

  setup)
    os::install "fontconfig"
    ;;

  --check-installed)
    command -v fc-list &> /dev/null && echo yes
    ;;

  --check-version)
    # the vesion is sent to stderr not stdout
    fc-list --version 2>&1 >/dev/null | cut -d ' ' -f 3
    ;;

esac
