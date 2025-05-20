autoload -U colors
colors
setopt prompt_subst

typeset -Ag FX FG BG

FX=(
    reset     "%{[00m%}"
    bold      "%{[01m%}" no-bold      "%{[22m%}"
    italic    "%{[03m%}" no-italic    "%{[23m%}"
    underline "%{[04m%}" no-underline "%{[24m%}"
    blink     "%{[05m%}" no-blink     "%{[25m%}"
    reverse   "%{[07m%}" no-reverse   "%{[27m%}"
)

for color in {000..255}; do
    FG[$color]="%{[38;5;${color}m%}"
    BG[$color]="%{[48;5;${color}m%}"
done

# Customizable parameters.
PROMPT_PATH_MAX_LENGTH=30
PROMPT_DEFAULT_END=❯
PROMPT_ROOT_END=❯❯❯
PROMPT_SUCCESS_COLOR=$FG[071]
PROMPT_FAILURE_COLOR=$FG[124]
PROMPT_VCS_INFO_COLOR=$FG[242]

# Set required options.
setopt promptsubst

# Load required modules.
autoload -Uz vcs_info

precmd() {
  vcs_info
  echo -ne "\e]1;$(basename `pwd`)\a"
}

# Set vcs_info parameters.
zstyle ':vcs_info:*' enable hg bzr git
zstyle ':vcs_info:*:*' check-for-changes false # Can be slow on big repos if set to true.
zstyle ':vcs_info:*:*' unstagedstr '!'
zstyle ':vcs_info:*:*' stagedstr '+'
zstyle ':vcs_info:*:*' actionformats "%S" "%r/%s/%b %u%c (%a)"
zstyle ':vcs_info:*:*' formats "%S" "%r/%s/%b %u%c"
zstyle ':vcs_info:*:*' nvcsformats "%~" ""

# Define prompts.
PROMPT="%(0?.%{$PROMPT_SUCCESS_COLOR%}.%{$PROMPT_FAILURE_COLOR%})${SSH_TTY:+[%n@%m]}%{$FX[no-bold]%}%$PROMPT_PATH_MAX_LENGTH<..<"'${vcs_info_msg_0_%%.}'"%<<%(!.$PROMPT_ROOT_END.$PROMPT_DEFAULT_END)%{$FX[no-bold]%}%{$FX[reset]%} "
RPROMPT="%{$PROMPT_VCS_INFO_COLOR%}"'$vcs_info_msg_1_'"%{$FX[reset]%}"
