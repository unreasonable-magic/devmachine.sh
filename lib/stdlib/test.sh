#!/usr/bin/env bash

stdlib::test::exists() {
  [ -e "$1" ]
}

stdlib::test::is_dir() {
  [ -d "$1" ]
}

stdlib::test::is_file() {
  [ -f "$1" ]
}

stdlib::test::strempty() {
  [ -z "$1" ]
}

stdlib::test::is_command() {
  command -v "$1" 2>&1 >/dev/null
}
