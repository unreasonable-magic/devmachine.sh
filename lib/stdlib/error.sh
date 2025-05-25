#!/usr/bin/env bash

source "$DEVMACHINE_PATH/lib/stdlib/error/stacktrace.bash"

stdlib::error::stacktrace() {
  if [[ "$BASH_SOURCE" != "" ]]; then
    stdlib::error::stacktrace::bash
  else
    echo "can't figure out backtrace"
  fi
}

# Prints an error to stderr then exits
stdlib::error::fatal() {
  printf "$(basename "$0"): $1\n" "${@:2}" >&2
  exit 1
}
