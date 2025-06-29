#!/usr/bin/env bash

for arg; do
  if version="$(os::detect "$arg")"; then
    printf "\e[1m\e[38;5;2m✓\e[0m %s \e[38;5;3m%s\e[0m\n" "$arg" "$version"
  else
    printf "\e[1m\e[38;5;1m✗\e[0m %s\n" "$arg"
  fi
done
