#!/usr/bin/env bash

devicon() {
  local icon="$1"

  # Make sure our dev icon cache root dir exists
  local cache_root=""
  if ! stdlib::test::strblank "$XDG_CACHE_HOME"; then
    cache_root="$XDG_CACHE_HOME/devicons"
  else
    cache_root="$HOME/.devicons"
  fi
  mkdir -p "$cache_root"

  # Now see if the icon we want exists. If it's not already on the filesystem,
  # download it, then show it
  icon_path="${cache_root}/${icon}.ansi"
  if ! stdlib::test::isfile "${icon_path}"; then
    url="https://raw.githubusercontent.com/keithpitt/devicons.sh/refs/heads/main/icons/${icon}/${icon}.ansi"
    curl -fLo "$icon_path" --silent --create-dirs "$url"
  fi

  cat "${icon_path}"
}

