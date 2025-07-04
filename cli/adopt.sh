#!/usr/bin/env bash

# Comes up with a "best guess" name for the devfile. It's probably wrong
# in a bunch of ways, but that's ok, it's just an educated guess.
#
# .config/raycast => raycast
# .config/raycast/config => raycast
# .config/vim => vim
# .gitignore => git
# .gitconfig => git
# .git/config => git
# .config/ghostty/config => ghostty
# .config/ghostty/config => ghostty
# .irbrc => irb
# .vimrc => vim
# .zshrc => vim
# .zshenv => zsh
# rspec => rspec
guess_devfile_name() {
  local name="$1"

  # Let's start by removing boring keys from the end of the string
  name="${name%.conf}"
  name="${name%.jsonc}"
  name="${name%.toml}"
  name="${name%.json}"
  name="${name%.yaml}"
  name="${name%rc}"
  name="${name%config}"
  name="${name%ignore}"
  name="${name%env}"

  # Remove any trailing / after we've removed boring keys
  name="${name%/}"

  # Get the last element in the path
  name="${name##*/}"

  # Remove the "." from the start if there is one
  name="${name#.}"

  echo "$name"
}

devfile_name="$(guess_devfile_name "$1")"

# Construct the "os::linkfile" part of the devfile
link_files=""
for file in "$@"; do
  source_file="$devfile_name/$(basename "$file")"
  target_link="${file/$HOME/\~}"
  link_files+="os::linkfile \"${source_file}\" \"${target_link}\""
done

# Put our final devfile together. The code here has whacky indentation
# because I want the strings to not have indentation when I save them
# to disk.
#
# The 2 main types of devfile here are:
#
# 1) There's a package with the same name that's already been installed
# using a package manager
#
# 2) Just rando files
#
command_name=""
if os::installcheck "$devfile_name"; then
  command_name="${devfile_name}"

body="#!/usr/bin/env devmachine

case \"\$1\" in

  setup)
    os::install \"$command_name\"
    ;;

  configure)
    $link_files
    ;;

  --is-installed)
    stdlib_test_is_command $command_name && echo yes
    ;;

esac"

else

body="#!/usr/bin/env devmachine

case \"\$1\" in

  configure)
    $link_files
    ;;

esac"

fi

path="$DEVFILES_PATH/${devfile_name}.sh"

# Use `bat` if it's installed to do a nicer render of the preview file
if stdlib_test_iscommand bat; then
  echo "$body" | bat --file-name "$path" --language bash
else
  echo "File: $path"
  echo
  echo "$body" | cat -n
fi

# Make sure we're good to move
echo
read -r -p "Create and move files? (ENTER to continue or CTRL-C to cancel) " confirm
echo

# Move to all the files
dest_path="$DEVFILES_PATH/${devfile_name}"

ui::logsh "mkdir" "-p" "$dest_path"
mkdir -p "$dest_path"

for file in "$@"; do
  ui::logsh "cp" $(realpath "$file") "${dest_path}/"
  cp $(realpath "$file") "${dest_path}/"
done

echo "$body" > "$path"
