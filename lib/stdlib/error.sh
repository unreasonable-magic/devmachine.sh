#!/usr/bin/env bash

stdlib::error::fatal() {
  echo "$1"
  exit 1
}
