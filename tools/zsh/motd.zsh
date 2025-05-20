ms=$((DEVMACHINE_INIT_RUNTIME / 1000000))

printf " Zsh ${ZSH_VERSION:0:3} \x1b[38;5;%sm%s\e[0m\n" "238" "(init ${ms}ms)"
