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

  sorted_devfiles=""
  for devfile in "${DEVFILES_PATH}"/*.sh; do
    # Cleanup the name by removing the folder and she .sh prefix
    devfile="${devfile##*/}"
    devfile="${devfile/.sh/}"

    local priority="$(devmachine "$devfile" --check-priority)"
    if [[ "$priority" == "high" ]]; then
      priority="100"
    fi
    sorted_devfiles+="${priority:-0}\t$devfile\n"
  done

  # Now we have a devfile list like:
  #
  #   0   foo
  #   100 bar
  #   0   bag
  #
  # We want to sort it based on priority so the important stuff
  # is always at the top
  sorted_devfiles="$(echo -e "$sorted_devfiles" |
    sort -k 1,1nr -k2,2 |
    tr -s '\n' |
    awk '{print $2}')"

  for devfile in ${sorted_devfiles}; do
    if [[ "$filter" == *installed* ]]; then
      check=$($DEVMACHINE_PATH/bin/devmachine "$devfile" --check-installed)

      if [[ "$filter" == "installed" && "$check" == "yes" ]]; then
        echo "$devfile"
      elif [[ "$filter" == "notinstalled" && "$check" == "" ]]; then
        echo "$devfile"
      fi
    else
      echo "$devfile"
    fi
  done
}

devfile::actions() {
  local path="$1"

  # Peeks into the tool file and look for all the
  # case definitions, i.e. "setup)" "--check-installed" etc.
  #
  # It then strips the leading whitespace, as well as the trailing ")"
  actions=$(
    cat "$path" |
      grep --extended-regexp --ignore-case '^\s*[a-z\.\-]+)' |
      sed -E "s/^ *//g" |
      sed -E "s/\)$//g"
    )

  echo "$actions"
}
