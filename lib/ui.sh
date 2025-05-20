#!/usr/bin/env bash

ui::image() {
  encoded=$(echo "$1" | tr -d '\n' | base64 | tr -d '=' | tr -d '\n')

  printf "\n\e_Ga=T,q=2,f=100,t=f,c=17,r=10;%s\e\\ \n\n" "$encoded"
}
