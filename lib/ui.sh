#!/usr/bin/env bash

ui::image() {
  encoded=$(echo "$1" | tr -d '\n' | base64 | tr -d '=' | tr -d '\n')
  cols="$2"
  rows="$3"

  printf "\n\e_Ga=T,q=2,f=100,t=f,c=$cols,r=$rows;%s\e\\ \n\n" "$encoded"
}
