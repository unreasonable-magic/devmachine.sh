#!/usr/bin/env bash

eval "$(stdlib shellenv)"

stdlib::import "error"
stdlib::import "test"
stdlib::import "image"
stdlib::import "array"
stdlib::import "color"
stdlib::import "debugger"
stdlib::import "url"

source "$DEVMACHINE_PATH/lib/devmachine/version.sh"
source "$DEVMACHINE_PATH/lib/devmachine/ui.sh"
source "$DEVMACHINE_PATH/lib/devmachine/cache.sh"
source "$DEVMACHINE_PATH/lib/devmachine/os.sh"
source "$DEVMACHINE_PATH/lib/devmachine/devicon.sh"
source "$DEVMACHINE_PATH/lib/devmachine/devfile.sh"
source "$DEVMACHINE_PATH/lib/devmachine/shell.sh"
