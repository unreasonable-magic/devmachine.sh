#!/usr/bin/env bash

source "$DEVMACHINE_PATH/lib/devmachine.sh"


generate_name() {
  # If the first argument is a directory, use the name of that:
  #
  #   +adopt ~/.config/raycast == "raycast"
  #   +adopt ~/.config/vim == "vim"
  #
  if stdlib::test::isdir "$1"; then
    name="$(basename "$1")"

    # If the name is something boring like "config" then that's not
    # very useful so we just won't use it
    if [[ "$name" != *config* ]]; then
      devfile_name="$name"
      return
    fi
  fi

  # If the first argument is a file with (rc) at the end of it,
  # use the prefix
  #
  #   +adopt ~/.vimrc == "vim"
  #   +adopt ~/.bashrc == "bash"
  #
  if stdlib::test::isfile "$1"; then
    if [[ "$1" =~ rc$ ]]; then
      # Remove the "rc" from the end
      devfile_name="$(basename -s "rc" $1)"

      # Remove the "." from the start if there is one
      devfile_name="${devfile_name#.}"

      return
    fi
  fi

  # If the first file is a file and it has a generic name like
  # "config" or "env", use it's folder name
  if stdlib::test::isfile "$1"; then
    name="$(basename "$1")"
    if [[ "$name" == *config* || "$name" == *env* ]]; then
      # Get the path to the directory and get the folder name
      full_path="$(dirname "$1")"
      directory_name="${full_path##*/}"
      devfile_name="${directory_name}"

      # Remove the "." from the start if there is one
      devfile_name="${devfile_name#.}"
    fi
  fi

}

# once we've guessted the name, look into the os::install list to see
# if a name exists and if it does, use that in install. also peek to see
# if there's a command with the smae name, and if ther eis, set that up too

devfile_name=""
generate_name "$1"

body="#!/usr/bin/env devmachine

case \"\$1\" in

  configure)
    $@
    ;;

esac"

echo "$body"

read -r -p "Name (default $devfile_name): " devfile_name

echo
