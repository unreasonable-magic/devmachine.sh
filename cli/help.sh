#!/usr/bin/env bash

cat <<- 'EOF'
     _                                 _     _
  __| | _____   ___ __ ___   __ _  ___| |__ (_)_ __   ___
 / _` |/ _ \ \ / / '_ ` _ \ / _` |/ __| '_ \| | '_ \ / _ \
| (_| |  __/\ V /| | | | | | (_| | (__| | | | | | | |  __/
 \__,_|\___| \_/ |_| |_| |_|\__,_|\___|_| |_|_|_| |_|\___|

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
