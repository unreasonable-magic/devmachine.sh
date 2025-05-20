#!/usr/bin/env bash

for t in "${DEVMACHINE_PATH}"/tools/*.sh; do
  # Remove path from the tool name
  t="${t##*/}"

  # Now remove the extension
  t="${t/.sh/}"

  check=$($DEVMACHINE_PATH/bin/devtool "$t" --check-installed)

  if [[ "$check" == "yes" ]]; then
    printf "\e[38;7m"
    printf "%s " "$t"
    printf $($DEVMACHINE_PATH/bin/devtool "$t" --check-version)
    printf "\e[0m\n"
  else
    printf "%s\n" "$t"
  fi

done
