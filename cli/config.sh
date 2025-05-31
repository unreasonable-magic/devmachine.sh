#!/usr/bin/env bash

printenv() {
  ui::logconfig "$1" "${2:-${!1}}"
}

ui::logsection "Shell"

printenv "SHELL"
printenv "HOME" "$HOME"
printenv "RCFILE" "$HOME/.${SHELL}rc"

echo
ui::logsection "XDG"

printenv "XDG_BIN_HOME"
printenv "XDG_CACHE_HOME"
printenv "XDG_CONFIG_HOME"
printenv "XDG_DATA_HOME"
printenv "XDG_RUNTIME_DIR"
printenv "XDG_STATE_HOME"

echo
ui::logsection "Devmachine"

printenv "DEVMACHINE_PATH"
printenv "DEVMACHINE_VERSION"
printenv "DEVMACHINE_CACHE_PATH"
printenv "DEVFILES_PATH"
