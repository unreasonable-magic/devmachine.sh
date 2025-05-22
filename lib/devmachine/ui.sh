#!/usr/bin/env bash

ui::logfunc() {
  printf "\e[1m%s\e[0m \e[32m%s\e[0m\n" "$1" "${*:2}"
}
