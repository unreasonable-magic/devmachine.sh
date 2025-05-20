if [[ "$XDG_CACHE_HOME" == "" ]]; then
  echo '$XDG_CACHE_HOME not set'
  exit 1
fi

cache_path="$XDG_CACHE_HOME/devmachine"
shellenv_cache_path="$cache_path/shellenv_$SHELL.sh"

if [[ -e "$shellenv_cache_path" ]]; then

  source "$shellenv_cache_path"

else
  mkdir -p "$cache_path"

  tools=("homebrew" "mise" "vim" "lsd" "bat" "less" "zoxide")

  for t in ${tools[@]}; do
    shellenv="$(devtool "$t" shellenv $SHELL)"
    eval "$shellenv"
    echo -E "$shellenv" >> "$shellenv_cache_path"
  done
fi
