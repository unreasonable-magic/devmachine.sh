#!/usr/bin/env bash

if stdlib::test::strblank "$XDG_CACHE_HOME"; then
  DEVMACHINE_CACHE_PATH="$HOME/.devmachine/cache"
else
  DEVMACHINE_CACHE_PATH="$XDG_CACHE_HOME/devmachine"
fi

cache::bust() {
  rm -rf "$DEVMACHINE_CACHE_PATH"
}
