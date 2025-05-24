#!/usr/bin/env bash

source "$DEVMACHINE_PATH/lib/devmachine.sh"

cat <<- EOF
$(ui::banner::small)

Devfiles:
  devmachine NAME|PATH [ACTION]
  devmachine +all [ACTION]
  devmachine +installed [ACTION]
  devmachine +notinstalled [ACTION]
  devmachine +run ACTION [FILTERS] -- [ARGS]
  devmachine +ls [FILTERS]

Shell:
  devmachine +shell SHELL [ARGS]

Setup:
  devmachine +init
  devmachine +adopt PATH

Troubleshooting:
  devmachine +config
  devmachine +help
  devmachine +version

EOF
