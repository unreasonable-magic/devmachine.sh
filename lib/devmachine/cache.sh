#!/usr/bin/env bash

# Come up with a default cache path if one hasn't been set already
if stdlib::test::strempty "$DEVMACHINE_CACHE_PATH"; then
  if stdlib::test::strempty "$XDG_CACHE_HOME"; then
    DEVMACHINE_CACHE_PATH="$HOME/.devmachine/cache"
  else
    DEVMACHINE_CACHE_PATH="$XDG_CACHE_HOME/devmachine"
  fi
fi

cache::bust() {
  rm -rf "$DEVMACHINE_CACHE_PATH"
}
