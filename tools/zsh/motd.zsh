ms=$((DEVMACHINE_INIT_RUNTIME / 1000000))

printf " Zsh ${ZSH_VERSION} \x1b[38;5;%sm%s\e[0m\n" "238" "(init ${ms}ms)"
