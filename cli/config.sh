#!/usr/bin/env bash

source "$DEVMACHINE_PATH/lib/devmachine.sh"

echo "Shell:"
ui::logconfig "  SHELL" "$SHELL"
ui::logconfig "  HOME" "$HOME"
ui::logconfig "  RCFILE" "$HOME/.${SHELL}rc"
echo
echo "Config:"
ui::logconfig "  DEVMACHINE_PATH" "$DEVMACHINE_PATH"
ui::logconfig "  DEVMACHINE_VERSION" "$DEVMACHINE_VERSION"
ui::logconfig "  DEVFILES_PATH" "$DEVFILES_PATH"
