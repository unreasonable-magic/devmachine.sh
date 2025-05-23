#!/usr/bin/env bash

ui::logfunc() {
  printf "\e[0m%s\e[0m \e[32m%s\e[0m\n" "$1" "${*:2}"
}

ui::logconfig() {
  printf "\e[1m%s\e[0m: \e[32m%s\e[0m\n" "$1" "$2"
}

ui::logsh() {
  printf "\e[2m$ %s\e[0m \e[2m%s\e[0m\n" "$1" "${*:2}"
}
