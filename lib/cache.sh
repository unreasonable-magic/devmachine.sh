#!/usr/bin/env bash

DEVMACHINE_CACHE_PATH="$XDG_CACHE_HOME/devmachine"

cache::bust() {
  rm -rf "$DEVMACHINE_CACHE_PATH"
}
