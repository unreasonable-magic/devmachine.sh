#!/usr/bin/env bash

ui::banner::small() {
  stdlib::color::rainbow -f <<-'EOF'
     _                       _    _
  __| |_____ ___ __  __ _ __| |_ (_)_ _  ___
 / _` / -_) V / '  \/ _` / _| ' \| | ' \/ -_)
 \__,_\___|\_/|_|_|_\__,_\__|_||_|_|_||_\___|
EOF
}

ui::logfunc() {
  printf "\e[0m%s\e[0m \e[32m%s\e[0m\n" "$1" "${*:2}"
}

ui::loginfo() {
  printf "$1\n" "${@:2}"
}

ui::logconfig() {
  printf "%s=\e[0;32m%q\e[0m\n" "$1" "$2"
}

ui::logsection() {
  local text="$1"
  local extra="$2"

  local prefix="\e[38;5;240m#\e[0m"

  printf "$prefix ${COLOR_FG_BLUE}%s\e[0m" "$text"

  if [[ -n "$extra" ]]; then
    printf " ${COLOR_FG_YELLOW}%s\e[0m" "$extra"
  fi

  printf "\n"
}

ui::logsh() {
  printf "\e[2m$ %s\e[0m \e[2m%s\e[0m\n" "$1" "${*:2}"
}

ui::logerror() {
  printf "${COLOR_FG_RED}error:\e[0m %s\n" "$1" >&2
}
