#!/usr/bin/env bash

devfile::list() {
  for t in "${DEVFILES_PATH}"/*.sh; do
    # Remove path from the tool name
    t="${t##*/}"

    # Now remove the extension
    t="${t/.sh/}"

    echo "$t"
  done
}
