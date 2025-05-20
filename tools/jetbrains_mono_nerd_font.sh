#!/usr/bin/env devtool

case "$1" in

  setup)
    brew install fontconfig font-jetbrains-mono-nerd-font
    ;;

  --check-installed)
    test -e "$HOME/Library/Fonts/JetBrainsMonoNerdFont-Regular.ttf" && echo "yes"
    ;;

  --check-version)
    fc-query -f '%{fontversion}\n' "$HOME/Library/Fonts/JetBrainsMonoNerdFont-Regular.ttf" |
      awk '{printf "%.3f\n", $1/65536.0}'
    ;;

esac
