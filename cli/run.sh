#!/usr/bin/env bash

source "$DEVMACHINE_PATH/lib/devmachine.sh"

filter="$1"
args="${@:2}"

for name in $(devfile::list --filter $filter); do
  echo "$name"

  if [[ "$args" != "" ]]; then
    devmachine "$name" "$args"
    echo
  fi
done
