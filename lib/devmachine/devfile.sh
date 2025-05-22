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

devfile::run() {
  local action="$1"
  local devfile="${DEVFILE_NAME}"

  if [[ "$devfile" == "" ]]; then
    echo "devfile::run no devfile passed"
    exit 1
  fi

  devmachine "$devfile" "$action"
}
