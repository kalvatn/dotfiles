if [ $UID -eq 0 ]; then CARETCOLOR="red"; else CARETCOLOR="blue"; fi

USER_COLOR="green"
HOST_COLOR="blue"
PATH_COLOR="yellow"
CODE_COLOR="red"

local return_code="%(?..%{$fg[$CODE_COLOR]%}%? ↵%{$reset_color%})"
local user="%{$fg_bold[$USER_COLOR]%}%n%{$reset_color%}"
local host="%{$fg_bold[$HOST_COLOR]%}%m%{$reset_color%}"
local dir="%{$fg_bold[$PATH_COLOR]%}%3~%{$reset_color%}"
local caret="%{${fg_bold[$CARETCOLOR]}%}»%{$reset_color%}"

PROMPT='${user}@${host}|${dir} $(git_prompt_info)${caret} '

RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"
