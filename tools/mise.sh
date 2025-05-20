#!/usr/bin/env devtool

case "$1" in

  setup)
    curl https://mise.run | sh
    ;;

  install-ruby)
    mise use -g ruby@latest
    ;;

  install-python)
    mise use -g python@latest
    ;;

  shellenv)
    mise activate "$SHELL"
    ;;

  --check-installed)
    command -v mise &> /dev/null && echo yes
    ;;

  --check-version)
    echo $(mise version -q)
    ;;

esac
