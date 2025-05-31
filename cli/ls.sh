#!/usr/bin/env bash

filter="$1"

for name in $(devfile::list --filter $filter); do
  echo "$name"
done
