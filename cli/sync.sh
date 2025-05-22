#!/usr/bin/env bash

source "$DEVMACHINE_PATH/lib/devmachine.sh"

for name in $(devfile::list); do
  echo "$name"
  echo "----------------"

  if devmachine "$name" --check-eligible; then
    devmachine "$name" setup
  else
    echo "(not eligable, skipping...)"
  fi
done
