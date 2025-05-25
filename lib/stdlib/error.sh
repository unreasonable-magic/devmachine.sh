#!/usr/bin/env bash

# Prints an error to stderr then exits
stdlib::error::fatal() {
  printf "$(basename "$0"): $1\n" "${@:2}" >&2
  exit 1
}
