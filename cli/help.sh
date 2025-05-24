#!/usr/bin/env bash

source "$DEVMACHINE_PATH/lib/devmachine.sh"

cat <<- EOF
$(ui::banner:small)

Devfiles:
  devmachine NAME|PATH [ACTION]
  devmachine +all [ACTION]
  devmachine +installed [ACTION]
  devmachine +notinstalled [ACTION]

Shell:
  devmachine +bash|+zsh [ARGS]

Setup:
  devmachine +init
  devmachine +adopt PATH

Troubleshooting:
  devmachine +config [KEY]
  devmachine +help
  devmachine +version

EOF
