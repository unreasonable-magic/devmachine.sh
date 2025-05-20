#!/usr/bin/env devtool

case "$1" in

  logo)
    ui::image "$DEVMACHINE_PATH/tools/bash/logo.png" 20 10
    ;;

  setup)
    os::install "bash"
    ;;

  make-default)
    bash_path=$(which bash)
    grep -q "$bash_path" "/etc/shells" ||
      sudo sh -c "echo $bash_path >> /etc/shells"
    chsh -s "$bash_path"
    ;;

  shellenv)
    cat "$DEVMACHINE_PATH/tools/bash/shellenv.bash"
    ;;

  motd)
    source "$DEVMACHINE_PATH/tools/bash/motd.bash"
    ;;

  --check-installed)
    command -v bash &> /dev/null && echo yes
    ;;

  --check-version)
    bash -c 'echo $BASH_VERSION'
    ;;

esac
