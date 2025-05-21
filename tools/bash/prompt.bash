shell::prompt::render() {
  # Note: If you use bash's printf or echo -e, and if your text has \001 or
  # \002 immediately before a number, you'll hit a bash bug that causes it to
  # eat one digit too many when processing octal escapes – that is, \00142 will
  # be interpreted as octal 014 (followed by ASCII "2"), instead of the correct
  # octal 01 (followed by ASCII "42"). For this reason, use hexadecimal
  # versions \x01 and \x02 instead.
  local esc_open='\001\e['
  local esc_close='\002'

  local var_to_set=""
  if [[ "$1" == "-v" ]]; then
    var_to_set="$2"
    shift 2
  fi

  local format="$1"
  shift

  format="${format//fg.blue\{/${esc_open}34m${esc_close}}"
  format="${format//fg.dim\{/${esc_open}2m${esc_close}}"
  format="${format//fg.black\{/${esc_open}30m${esc_close}}"
  format="${format//bg.red\{/${esc_open}41m${esc_close}}"
  format="${format//fg.red\{/${esc_open}31m${esc_close}}"
  format="${format//fg.green\{/${esc_open}32m${esc_close}}"
  format="${format//bg.green\{/${esc_open}42m${esc_close}}"

  # not great handling, but capture a full bold call instead of just the
  # opening so we can reset it's sequene correctly (we can't blindly do a 0m
  # because you may want to bold something half way through text and keep all
  # other styling)
  format="${format//fg.bold\{%s\}/${esc_open}1m${esc_close}%s${esc_open}22m${esc_close}}"

  format="${format//\}/${esc_open}0m${esc_close}}"

  if [[ -z "${var_to_set}" ]]; then
    printf "$format" "$@"
  else
    printf -v "$var_to_set" "$format" "$@"
  fi
}

shell::prompt::setup() {
  exit_status()
  {
    local -i s="$1"
    local label=""

    if [[ $s != 0 ]]; then
      case $s in
        1)
          label="general error"
          ;;
        2)
          label="misuse of shell built-ins"
          ;;
        126)
          label="command cannot execute"
          ;;
        127)
          label="command not found"
          ;;
        128)
          label="invalid exit argument"
          ;;
        130)
          label="ctrl-c"
          ;;
        255)
          label="exit status out of range"
          ;;
        *)
          local signal=$((($s - 128) % 256))
          local sig_name=$(kill -l $signal 2>/dev/null || echo "?")
          label="signal: $sig_name"
      esac

      shell::prompt::render "fg.red{󱞽 }bg.red{fg.black{fg.bold{%s} fg.dim{%s}}}fg.red{}" "exit $s" "$label"
    fi
  }

  job_count()
  {
    # need to make sure we pass -r so its only running jobs
    local -i count=$(jobs -r | wc -l)
    if [[ "$count" -gt 0 ]]; then
      shell::prompt::render "fg.green{  jobs[%s]} " "${spinner[$index]}" "$count"
    fi
  }

  dynamic_prompt()
  {
    local -i exit_status="$?"

    exit_status "$exit_status"

    if [[ "$exit_status" != 0 ]]; then
      local -i terminal_cols="$(tput cols)"
      if [[ "$terminal_cols" -lt 100 ]]; then
        printf "\n\r"
      else
        printf " "
      fi
    fi

    job_count
  }


  local ps1_prompt=""
  shell::prompt::render -v "ps1_prompt" "\$(dynamic_prompt)fg.dim{%s} fg.dim{%s} " "\w" "$"
  export PS1="$ps1_prompt"
}

shell::prompt::setup
