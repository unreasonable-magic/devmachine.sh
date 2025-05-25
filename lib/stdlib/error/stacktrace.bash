#!/usr/bin/env bash

stdlib::error::stacktrace::bash() {
  local -i idx=1
  local -i length="${#BASH_SOURCE[@]}"

  while [[ "$idx" -lt "$length" ]]; do
    local source_file="${BASH_SOURCE[$idx]}"
    local func_name="${FUNCNAME[$idx]}"
    local line_no="${BASH_LINENO[$idx-1]}"

    printf "%s\n%s:%s\n\n" "$func_name" "$source_file" "$line_no"

    ((idx++))
  done
}
