#!/usr/bin/env bash

ui::banner::small() {
color <<- 'EOF'
     _                       _    _
  __| |_____ ___ __  __ _ __| |_ (_)_ _  ___
 / _` / -_) V / '  \/ _` / _| ' \| | ' \/ -_)
 \__,_\___|\_/|_|_|_\__,_\__|_||_|_|_||_\___|
EOF
}

ui::logfunc() {
  printf "\e[0m%s\e[0m \e[32m%s\e[0m\n" "$1" "${*:2}"
}

ui::logconfig() {
  printf "%s=\e[0;32m%q\e[0m\n" "$1" "$2"
}

ui::logsection() {
  printf "\e[38;5;243m# %s\e[0m\n" "$1"
}

ui::logsh() {
  printf "\e[2m$ %s\e[0m \e[2m%s\e[0m\n" "$1" "${*:2}"
}
