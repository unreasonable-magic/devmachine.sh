#!/usr/bin/env bash

source "$DEVMACHINE_PATH/lib/devmachine.sh"

installed_only="false"
for arg; do
  case "$arg" in
    --installed)
      installed_only="true"
      ;;
  esac
done

for t in "${DEVFILES_PATH}"/*.sh; do
  # Remove path from the tool name
  t="${t##*/}"

  # Now remove the extension
  t="${t/.sh/}"

  check=$($DEVMACHINE_PATH/bin/devtool "$t" --check-installed)

  if [[ "$check" == "yes" ]]; then
    printf "\e[0;32m"
    printf "%s " "$t"
    printf $($DEVMACHINE_PATH/bin/devtool "$t" --check-version)
    printf "\e[0m\n"
  else
    # Filter our non-installed tools if we've been told to
    if [[ "$installed_only" == "false" ]]; then
      printf "\e[38;5;234m%s\e[0m\n" "$t"
    fi
  fi

done
