#!/usr/bin/env bash

# By default bash will wipe out the history file each time you start
# a new bash session (which is very annoying when you open multiple
# windows). `histappend` tells bash to add to the current history
# file instead of wiping it
shopt -s histappend

# Also we want more history! Never forget!
HISTSIZE=100000

source "$DEVMACHINE_PATH/shell/bash/prompt.bash"
