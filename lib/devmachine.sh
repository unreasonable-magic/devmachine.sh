#!/usr/bin/env bash

eval "$(stdlib shellenv)"

stdlib::require "stdlib.sh/error.sh"
stdlib::require "stdlib.sh/test.sh"
stdlib::require "stdlib.sh/image.sh"
stdlib::require "stdlib.sh/array.sh"
stdlib::require "stdlib.sh/color.sh"

source "$DEVMACHINE_PATH/lib/devmachine/version.sh"
source "$DEVMACHINE_PATH/lib/devmachine/ui.sh"
source "$DEVMACHINE_PATH/lib/devmachine/cache.sh"
source "$DEVMACHINE_PATH/lib/devmachine/os.sh"
source "$DEVMACHINE_PATH/lib/devmachine/devicon.sh"
source "$DEVMACHINE_PATH/lib/devmachine/devfile.sh"
source "$DEVMACHINE_PATH/lib/devmachine/shell.sh"
