#!/usr/bin/env devtool

VIM_CONFIG_PATH="${VIM_CONFIG_PATH:-$HOME/.config/vim}"

case "$1" in

  logo)
    echo -e "\n$(cat ./tools/vim/logo.ansi)\n"
    ;;

  setup)
    os::install "vim"

    curl -fLo "$VIM_CONFIG_PATH/autoload/plug.vim" --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    os::linkfile "$DEVMACHINE_PATH/tools/vim/vimrc" "$VIM_CONFIG_PATH/vimrc"
    ;;

  edit-config)
    "$EDITOR" "$VIM_CONFIG_PATH/vimrc"
    vim +PluginInstall +qall
    ;;

  shellenv)
    echo 'export EDITOR="vim"'
    ;;

  --check-installed)
    command -v vim &> /dev/null && echo yes
    ;;

  --check-version)
    # This feels like it could be easier...
    vim --version |
      head -n 1 |
      sed -r 's:[^0-9\. ]*::g' |
      tr -s ' ' |
      cut -d ' ' -f 2
    ;;

esac
