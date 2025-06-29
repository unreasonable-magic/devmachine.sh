DETECT_INVALID_ARGS_ERROR=1
DETECT_COMMAND_NOT_FOUND_ERROR=166

stdlib::import "test"
stdlib::import "string/titleize"
stdlib::import "string/trim"

os::detect() {
  local command_name="$1"

  if [ -z "$command_name" ]; then
    return $DETECT_INVALID_ARGS_ERROR
  fi

  if ! command -v "$command_name" >/dev/null 2>&1; then
    # If it's not a CLI command, maybe it's a macOS app and we can sneak into
    # the plist and grab a version from that? (this is for things like chrome,
    # firefox, alacritty, etc.)
    local app_name
    titleize -v app_name "${command_name}"

    local macos_app="/Applications/${app_name}.app/Contents/Info.plist"
    if stdlib::test::is_file "$macos_app"; then
      grep "CFBundleShortVersionString" -A 1 "$macos_app" | tail -n 1 | sed -Er "s/[a-zA-Z<>\/ ]+//g" | trim
      return 0
    fi

    return $DETECT_COMMAND_NOT_FOUND_ERROR
  fi

  # Common version flags to try (in order of preference most likely)
  local possible_version_flags=(
    "--version"
    "-V"
    "-v"
    "version"
    "--help"
    "-h"
    "help"
  )

  for flag in "${possible_version_flags[@]}"; do
    local found_version_text=""

    if version_output=$("$command_name" "$flag" 2>&1); then
      found_version_text=$(
        echo "$version_output" |
          sed '/Copyright (c) [0-9]\{4\}-[0-9]\{4\}/d' |
          grep -oE '[0-9]+(\.[0-9]+)*(\.[0-9]+)*(-[a-zA-Z0-9]+)?' |
          head -1
      )

      if [ -n "$found_version_text" ]; then
        echo "$found_version_text"
        return 0
      fi
    fi
  done

  return 1
}
