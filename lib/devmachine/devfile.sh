#!/usr/bin/env bash

devfile::list() {
  local filter=""
  for arg; do
    case "$arg" in
      --filter)
        filter="$2"
        shift
        ;;
    esac
  done

  for t in "${DEVFILES_PATH}"/*.sh; do
    # Remove path from the tool name
    t="${t##*/}"

    # Now remove the extension
    t="${t/.sh/}"

    if [[ "$filter" == *installed* ]]; then
      check=$($DEVMACHINE_PATH/bin/devmachine "$t" --check-installed)

      if [[ "$filter" == "installed" && "$check" == "yes" ]]; then
        echo "$t"
      elif [[ "$filter" == "notinstalled" && "$check" == "" ]]; then
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

  "$DEVMACHINE_PATH/bin/devmachine" "$devfile" "$action"
}
