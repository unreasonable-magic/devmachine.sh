#!/usr/bin/env bash

cat <<-EOF
$(ui::banner::small)

$(ui::logsection "Devfiles")
devmachine NAME|PATH [ACTION]
devmachine +all [ACTION]
devmachine +installed [ACTION]
devmachine +notinstalled [ACTION]
devmachine +run ACTION [FILTERS] -- [ARGS]
devmachine +ls [FILTERS]

$(ui::logsection "Operating System")
devmachine +check COMMAND_NAME [ARGS]

$(ui::logsection "Shell")
devmachine +shell SHELL [ARGS]

$(ui::logsection "Setup")
devmachine +init
devmachine +adopt PATH

$(ui::logsection "Troubleshooting")
devmachine +config
devmachine +help
devmachine +version

EOF
