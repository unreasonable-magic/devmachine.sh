#!/usr/bin/env bash

source "$DEVMACHINE_PATH/lib/stdlib/error.sh"
source "$DEVMACHINE_PATH/lib/stdlib/test.sh"
source "$DEVMACHINE_PATH/lib/stdlib/image.sh"

source "$DEVMACHINE_PATH/lib/devmachine/ui.sh"
source "$DEVMACHINE_PATH/lib/devmachine/cache.sh"
source "$DEVMACHINE_PATH/lib/devmachine/os.sh"
source "$DEVMACHINE_PATH/lib/devmachine/devicon.sh"
source "$DEVMACHINE_PATH/lib/devmachine/devfile.sh"

if stdlib::test::strblank "$XDG_CACHE_HOME"; then
  DEVMACHINE_CACHE_PATH="$HOME/.devmachine/cache"
else
  DEVMACHINE_CACHE_PATH="$XDG_CACHE_HOME/devmachine"
fi
