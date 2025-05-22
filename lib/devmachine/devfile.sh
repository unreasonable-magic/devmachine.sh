#!/usr/bin/env bash

devfile::list() {
  local only_installed="false"
  for arg; do
    case "$arg" in
      --installed)
        only_installed="true"
        ;;
    esac
  done

  for t in "${DEVFILES_PATH}"/*.sh; do
    # Remove path from the tool name
    t="${t##*/}"

    # Now remove the extension
    t="${t/.sh/}"

    if [[ "$only_installed" == "true" ]]; then
      check=$($DEVMACHINE_PATH/bin/devmachine "$t" --check-installed)

      if [[ "$check" == "yes" ]]; then
        echo "$t"
      fi
    else
      echo "$t"
    fi
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
