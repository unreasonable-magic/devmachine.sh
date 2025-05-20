#!/usr/bin/env devtool

case "$1" in

  setup)
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ;;

  shellenv.priority)
    /opt/homebrew/bin/brew shellenv

    # man bash always shows the installed version of man, not the one
    # installed with homebrew. dunno why...
    echo 'alias brewman="man -M /opt/homebrew/share/man"'

    ;;

  --check-installed)
    command -v brew &> /dev/null && echo yes
    ;;

  --check-version)
    brew --version | cut -d ' ' -f 2
    ;;

esac
