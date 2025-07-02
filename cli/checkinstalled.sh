#!/usr/bin/env bash

stdlib::import "capture"

if [[ $# -eq 0 ]]; then
  ui::logerror "+checkinstalled requires at least 1 argument"
  exit 1
fi

for arg; do
  if stdout="$(os::detect_installed "$arg")"; then
    printf "\e[1m\e[38;5;2m✓\e[0m %s \e[38;5;3m%s\e[0m\n" "$arg" "$stdout"
  else
    printf "\e[1m\e[38;5;1m✗\e[0m %s\n" "$arg"
    had_missing=true
  fi

  if [[ -n "$had_missing" ]]; then
    exit 1
  fi
done
