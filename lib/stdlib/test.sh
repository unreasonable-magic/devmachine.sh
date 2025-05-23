#!/usr/bin/env bash

stdlib::test::exists() {
  [ -e "$1" ]
}

stdlib::test::isdir() {
  [ -d "$1" ]
}

stdlib::test::isfile() {
  [ -f "$1" ]
}

stdlib::test::strblank() {
  [ -z "$1" ]
}

stdlib::test::iscommand() {
  command -v "$1" 2>&1 >/dev/null
}
