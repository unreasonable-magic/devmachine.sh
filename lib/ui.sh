#!/usr/bin/env bash

ui::image() {
  path="$1"
  cols="$2"
  rows="$3"

  if [[ "$TERM_PROGRAM" == "iTerm.app" ]]; then
    "$DEVMACHINE_PATH/lib/stdlib/image/iterm.sh" -W "${cols}" -H "${rows}" "$path"
  else
    encoded=$(echo "$path" | tr -d '\n' | base64 | tr -d '=' | tr -d '\n')

    printf "\n\e_Ga=T,q=2,f=100,t=f,c=$cols,r=$rows;%s\e\\ \n\n" "$encoded"
  fi
}
