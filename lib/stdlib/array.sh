#!/usr/bin/env bash

stdlib::array::join() {
  local IFS=$'\n'
  shift
  echo "$*"
}
