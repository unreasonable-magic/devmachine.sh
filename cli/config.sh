#!/usr/bin/env bash

source "$DEVMACHINE_PATH/lib/devmachine.sh"

get() {
  case "$1" in
    DEVMACHINE_VERSION)
      echo "$DEVMACHINE_VERSION"
      ;;
    DEVMACHINE_CACHE_PATH)
      echo "$DEVMACHINE_CACHE_PATH"
      ;;
    DEVMACHINE_PATH)
      echo "$DEVMACHINE_PATH"
      ;;
    DEVFILES_PATH)
      echo "$DEVFILES_PATH"
      ;;
    *)
      stdlib::error::fatal "unknown config $1"
      ;;
  esac
}

key="$1"

if stdlib::test::strblank $key; then
  declare -a all=(
    "DEVMACHINE_VERSION"
    "DEVMACHINE_PATH"
    "DEVMACHINE_CACHE_PATH"
    "DEVFILES_PATH"
  )

  for k in "${all[@]}"; do
    ui::logconfig "$k" "$(get "$k")"
  done
else
  get "$key"
fi
