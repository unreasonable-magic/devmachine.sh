#!/usr/bin/env bash

if [[ $# -eq 0 ]]; then
  ui::logerror "+checkinstalled requires at least 1 argument"
  exit 1
fi

for arg; do
  output=""
  if output="$(os::detect_installed "$arg" 2>&1)"; then
    printf "\e[1m\e[38;5;2m✓\e[0m %s \e[38;5;3m%s\e[0m\n" "$arg" "$output"
  else
    printf "\e[1m\e[38;5;1m✗\e[0m %s %s\n" "$arg" "$output"
    exit 1
  fi
done
