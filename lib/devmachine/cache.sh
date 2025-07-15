#!/usr/bin/env bash

# Come up with a default cache path if one hasn't been set already
if stdlib_test string/is_empty "$DEVMACHINE_CACHE_PATH"; then
  if stdlib_test string/is_empty "$XDG_CACHE_HOME"; then
    DEVMACHINE_CACHE_PATH="$HOME/.devmachine/cache"
  else
    DEVMACHINE_CACHE_PATH="$XDG_CACHE_HOME/devmachine"
  fi
fi

cache::bust() {
  rm -rf "$DEVMACHINE_CACHE_PATH"
}
