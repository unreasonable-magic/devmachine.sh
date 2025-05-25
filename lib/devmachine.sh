#!/usr/bin/env bash

eval "$(stdlib shellenv)"

stdlib::require "stdlib.sh/error.sh"
stdlib::require "stdlib.sh/test"
stdlib::require "stdlib.sh/image"
stdlib::require "stdlib.sh/array"
stdlib::require "stdlib.sh/color"
stdlib::require "stdlib.sh/debugger"

source "$DEVMACHINE_PATH/lib/devmachine/version.sh"
source "$DEVMACHINE_PATH/lib/devmachine/ui.sh"
source "$DEVMACHINE_PATH/lib/devmachine/cache.sh"
source "$DEVMACHINE_PATH/lib/devmachine/os.sh"
source "$DEVMACHINE_PATH/lib/devmachine/devicon.sh"
source "$DEVMACHINE_PATH/lib/devmachine/devfile.sh"
source "$DEVMACHINE_PATH/lib/devmachine/shell.sh"
