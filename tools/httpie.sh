#!/usr/bin/env devtool

case "$1" in

  setup)
    devmachine::install "httpie"
    ;;

  --check-installed)
    command -v httpie &> /dev/null && echo yes
    ;;

  --check-version)
    httpie --version
    ;;

esac
