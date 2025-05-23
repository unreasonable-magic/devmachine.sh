#!/usr/bin/env bash


cache::bust() {
  rm -rf "$DEVMACHINE_CACHE_PATH"
}

cache::path() {
  echo "$DEVMACHINE_CACHE_PATH"
}
