#!/usr/bin/env bash

ui::banner::small() {
stdlib::color::rainbow -f <<- 'EOF'
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
  local text="$1"

  local prefix="\e[38;5;240m#\e[0m"
  local text_color="38;5;4"

  printf "$prefix \e[${text_color}m%s\e[0m\n" "$text"
}

ui::logsh() {
  printf "\e[2m$ %s\e[0m \e[2m%s\e[0m\n" "$1" "${*:2}"
}
