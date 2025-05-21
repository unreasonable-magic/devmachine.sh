#!/usr/bin/env bash

stdlib::image::print() {
  local path="$1"
  local cols="$2"
  local rows="$3"

  if [[ "$TERM_PROGRAM" == "iTerm.app" ]]; then
    "$DEVMACHINE_PATH/lib/stdlib/image/iterm.sh" -W "${cols}" -H "${rows}" "$path"
  else
    encoded=$(echo "$path" | tr -d '\n' | base64 | tr -d '=' | tr -d '\n')

    printf "\n\e_Ga=T,q=2,f=100,t=f,c=$cols,r=$rows;%s\e\\ \n\n" "$encoded"
  fi
}

stdlib::image::dimensions() {
  local path="$(realpath $1)"

  if [[ "$path" == *.png ]]; then
    # This is extreemly not portable, but that's not a problem at the moment
    echo $(/sbin/file "$path" | grep "PNG image" | awk '{print $5, $7}' | sed 's/,//g')
  else
    echo "don't know how to handle $path yet"
    exit 1
  fi
}
