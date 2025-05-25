#!/usr/bin/env bash

stdlib::color() {
  while IFS= read -r line; do
    printf "\e[33m%s\e[0m\n" "$line"
  done
}

stdlib::color::rainbow() {
  if stdlib::test::is_command "lolcat"; then
    lolcat -f
  else
    while IFS= read -r line; do
      printf "\e[33m%s\e[0m\n" "$line"
    done
  fi
}
