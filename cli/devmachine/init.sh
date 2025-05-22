#!/usr/bin/env bash

source "$DEVMACHINE_PATH/lib/devmachine.sh"

# Start out by making sure we've got a shell we should be looking
# to take over
target_shell="${1:-$SHELL}"
[ -z "$target_shell" ] && stdlib::error::fatal "no shell passed"

rc_file=""
if [[ "$target_shell" == "zsh" ]]; then
  rc_file="$HOME/.zshrc"
elif [[ "$target_shell" == "bash" ]]; then
  rc_file="$HOME/.bashrc"
else
  stdlib::error::fatal "unsupported shell $target_shell"
fi

printf -v new_rc_body "export DEVMACHINE_PATH=\'%q\'\neval \"\$(\$DEVMACHINE_PATH/bin/devmachine +shellenv \$(which \${0#-}))\"" $DEVMACHINE_PATH

echo "devmachine needs to take over your $rc_file file"
echo
echo "the following will be written to it:"
echo
echo "$new_rc_body"
echo

if [[ -e "$rc_file" ]]; then
  echo "as $rc_file already exists, a backup will be made first"
  echo
fi

read -r -p "lets go? (ENTER to continue or CTRL-C to cancel) " confirm

if [[ $confirm == "" ]]; then
  if [[ -e "$rc_file" ]]; then
    timestamp="$(date +%Y%m%d%H%M%S)"
    rc_backup_filename="$rc_file.$timestamp.devmachinebackup"
    cp "$rc_file" "$rc_backup_filename"

    echo
    echo "backup saved to $rc_backup_filename"
  fi

  echo "$new_rc_body" > $rc_file

  echo
  echo "$rc_file has been updated"
fi
