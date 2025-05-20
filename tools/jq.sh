#!/usr/bin/env devtool

case "$1" in

  setup)
    devmachine::install "jq"
    ;;

  --check-installed)
    command -v jq &> /dev/null && echo yes
    ;;

  --check-version)
    jq --version
    ;;

esac
