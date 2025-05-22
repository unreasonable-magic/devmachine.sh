#!/usr/bin/env bash

source "$DEVMACHINE_PATH/lib/devmachine.sh"

for name in $(devfile::list); do
  echo "$name"

  if [[ "$1" != "" ]]; then
    echo "----------------"
    devmachine "$name" "$1"
  fi
done
