export HISTDIR="$XDG_STATE_HOME/bash"
export HISTFILE="$HISTDIR/history"
export HISTSIZE=5000000
export SAVEHIST=$HISTSIZE

mkdir -p "$HISTDIR"

# By default bash will wipe out the history file each time you start
# a new bash session (which is very annoying when you open multiple
# windows). `histappend` tells bash to add to the current history
# file instead of wiping it
shopt -s histappend
