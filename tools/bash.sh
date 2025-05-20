#!/usr/bin/env devtool

case "$1" in

  setup)
    devmachine::install "bash"
    ;;

  make-default)
    bash_path=$(which bash)
    grep -q "$bash_path" "/etc/shells" ||
      sudo sh -c "echo $bash_path >> /etc/shells"
    chsh -s "$bash_path"
    ;;

  --check-installed)
    command -v bash &> /dev/null && echo yes
    ;;

  --check-version)
    bash -c 'echo $BASH_VERSION'
    ;;

esac
