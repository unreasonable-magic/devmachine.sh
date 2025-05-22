#!/usr/bin/env bash

source "$DEVMACHINE_PATH/lib/devmachine.sh"

for name in $(devfile::list --installed); do
  echo "$name"

  if [[ "$1" != "" ]]; then
    echo "----------------"
    devmachine "$name" "$1"
  fi
done
