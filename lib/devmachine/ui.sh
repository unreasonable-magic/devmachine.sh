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

  local border_char="∿"
  local border_color="38;5;245"

  local border_h=""
  printf -v border_h "%*s" $((${#text} + 4))
  border_h="${border_h// /$border_char}"
  border_h="\e[${border_color}m${border_h}\e[0m"

  local border_v="${border_char}"
  border_v="\e[${border_color}m${border_v}\e[0m"

  local prefix="\e[38;5;238m#\e[0m"
  local text_color="38;5;248"

  printf "$prefix ${border_h} \e[0m\n"
  printf "$prefix ${border_v} \e[${text_color}m%s\e[0m ${border_v} \e[0m\n" "$text"
  printf "$prefix ${border_h} \e[0m\n"
}

ui::logsh() {
  printf "\e[2m$ %s\e[0m \e[2m%s\e[0m\n" "$1" "${*:2}"
}
