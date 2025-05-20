ms=$((DEVMACHINE_INIT_RUNTIME / 1000000))

# Print the thing
printf " Bash ${BASH_VERSION:0:3} \x1b[38;5;%sm%s\e[0m\n" "238" "(init ${ms}ms)"
