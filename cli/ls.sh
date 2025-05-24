#!/usr/bin/env bash

source "$DEVMACHINE_PATH/lib/devmachine.sh"

filter="$1"

for name in $(devfile::list --filter $filter); do
  echo "$name"
done
