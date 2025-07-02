#!/usr/bin/env bash

filter="$1"
args="${@:2}"

for name in $(devfile::list --filter $filter); do
  ui::logsection "$name" "$(os::detect_installed "$name")"

  if [[ "$args" != "" ]]; then
    devmachine "$name" "$args"
    echo
  fi
done
