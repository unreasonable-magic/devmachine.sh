#!/usr/bin/env devtool

case "$1" in

  setup)
    os::install "zsh"
    ;;

  make-default)
    zsh_path=$(which zsh)
    grep -q "$zsh_path" "/etc/shells" ||
      sudo sh -c "echo $zsh_path >> /etc/shells"
    chsh -s "$zsh_path"
    ;;

  shellenv)
    if [[ "$2" == "zsh" ]]; then
      cat "$DEVMACHINE_PATH/tools/zsh/prompt.zsh"
      cat "$DEVMACHINE_PATH/tools/zsh/completions.zsh"
      cat "$DEVMACHINE_PATH/tools/zsh/history.zsh"
    else
      echo "# skipping zsh shellenv"
    fi
    ;;

  motd)
    exec "$DEVMACHINE_PATH/tools/zsh/motd.zsh"
    ;;

  --check-installed)
    command -v zsh &> /dev/null && echo yes
    ;;

  --check-version)
    zsh --version | cut -d ' ' -f 2
    ;;

esac
