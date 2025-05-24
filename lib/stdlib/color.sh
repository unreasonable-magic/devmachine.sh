#!/usr/bin/env bash

color() {
  while IFS= read -r line; do
    printf "\e[33m%s\e[0m\n" "$line"
  done
}
