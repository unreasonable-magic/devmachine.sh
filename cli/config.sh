#!/usr/bin/env bash

source "$DEVMACHINE_PATH/lib/devmachine.sh"

echo "Shell:"
ui::logconfig "  SHELL" "$SHELL"
ui::logconfig "  HOME" "$HOME"
ui::logconfig "  RCFILE" "$HOME/.${SHELL}rc"
echo
echo "XDG:"
ui::logconfig "  XDG_BIN_HOME" "${XDG_BIN_HOME/$HOME/~}"
ui::logconfig "  XDG_CACHE_HOME" "${XDG_CACHE_HOME/$HOME/~}"
ui::logconfig "  XDG_CONFIG_HOME" "${XDG_CONFIG_HOME/$HOME/~}"
ui::logconfig "  XDG_DATA_HOME" "${XDG_DATA_HOME/$HOME/~}"
ui::logconfig "  XDG_RUNTIME_DIR" "${XDG_RUNTIME_DIR/$HOME/~}"
ui::logconfig "  XDG_STATE_HOME" "${XDG_STATE_HOME/$HOME/~}"
echo
echo "Config:"
ui::logconfig "  DEVMACHINE_PATH" "$DEVMACHINE_PATH"
ui::logconfig "  DEVMACHINE_VERSION" "$DEVMACHINE_VERSION"
ui::logconfig "  DEVFILES_PATH" "$DEVFILES_PATH"
