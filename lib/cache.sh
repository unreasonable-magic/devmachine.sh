#!/usr/bin/env bash

cache::bust() {
  rm -rf "$XDG_CACHE_HOME/lib/cli/devmachine"
}
