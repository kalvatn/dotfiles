#!/usr/bin/env zsh

[[ "$COLORTERM" == "gnome-terminal" ]] && export TERM="xterm-256color"


# BEGIN ANSIBLE MANAGED BLOCK .zpresto/init.zsh
ZPREZTO_INIT_FILE="${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
if [ -s "$ZPREZTO_INIT_FILE" ]; then
  source "$ZPREZTO_INIT_FILE"
fi
# END ANSIBLE MANAGED BLOCK .zpresto/init.zsh

autoload -U compinit
compinit
zmodload -i zsh/complist

autoload -Uz colors zsh-mime-setup select-word-style
colors
zsh-mime-setup
select-word-style bash


# autoload predict-on
# predict-toggle() {
#   ((predict_on=1-predict_on)) && predict-on || predict-off
# }
# zle -N predict-toggle
# bindkey '^Z'   predict-toggle
# zstyle ':predict' toggle true
# zstyle ':predict' verbose true

bindkey -v

autoload -Uz edit-command-line

bindkey -M vicmd 'v' edit-command-line

# if mode indicator wasn't setup by theme, define default
if [[ "$MODE_INDICATOR" == "" ]]; then
  MODE_INDICATOR="%{$fg_bold[red]%}<%{$fg[red]%}<<%{$reset_color%}"
fi

function vi_mode_prompt_info() {
  local return_code="%(?..%?)"
  # echo "${${KEYMAP/vicmd/$MODE_INDICATOR}/(main|viins)/}${return_code}"
  echo "${${KEYMAP/vicmd/NORMAL - }/(main|viins)/}${return_code}"
}

if [[ "$RPS1" == "" && "$RPROMPT" == "" ]]; then
  RPS1='$(vi_mode_prompt_info)'
fi


# Ensure that the prompt is redrawn when the terminal size changes.
TRAPWINCH() {
  zle && { zle reset-prompt; zle -R }
}
zle-keymap-select () {
  zle reset-prompt
  zle -R
  if [ $KEYMAP = vicmd ]; then
    if [[ $TMUX = '' ]]; then
      echo -ne "\033]12;Red\007"
    else
      printf '\033Ptmux;\033\033]12;red\007\033\\'
    fi
  else
    if [[ $TMUX = '' ]]; then
      echo -ne "\033]12;Grey\007"
    else
      printf '\033Ptmux;\033\033]12;grey\007\033\\'
    fi
  fi
}

zle-line-init () {
  zle -K viins
  echo -ne "\033]12;Grey\007"
}

zle -N edit-command-line
zle -N zle-line-init
zle -N vi_mode_prompt_info
zle -N zle-keymap-select
export KEYTIMEOUT=1

setopt hash_list_all
setopt completealiases
setopt always_to_end
setopt complete_in_word
setopt list_ambiguous

unsetopt correct
unsetopt correct_all


zstyle ':completion:*' rehash true
zstyle ':completion::complete:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select=2
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

zstyle ':completion:*' verbose yes
# zstyle ':completion:*:descriptions' format $'\e[00;34m%d'
# zstyle ':completion:*:messages' format $'\e[00;31m%d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:manuals' separate-sections true


# compdef _gnu_generic gcc
# compdef _gnu_generic gdb

# setopt auto_pushd
# setopt pushd_ignore_dups
# setopt pushd_silent
# setopt pushd_to_home

export HISTCONTROL=ignoredups:erasedups
export HISTFILE=~/.zsh_history
export HISTSIZE=20000
export SAVEHIST=20000
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_allow_clobber
setopt hist_ignore_space
setopt hist_no_store
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt extended_history
setopt hist_reduce_blanks
setopt hist_verify
setopt append_history
setopt inc_append_history
setopt share_history
setopt bang_hist



set -o vi
export EDITOR='vim'
export VISUAL='vim'

# if command -v vim > /dev/null; then
#   # use vim as pager
#   # export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""
#   export PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
# /usr/bin/vim -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' \
# -c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
# -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""
# fi

# -X (--no-init) -F (--quit-if-one-screen) -R (--RAW-CONTROL-CHARS)
export LESS="-XFR"

export PATH="$HOME/bin:$HOME/workbin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

if [ -f "$HOME/.aliases" ]; then
  source $HOME/.aliases
fi

if [ -f "$HOME/.variables" ]; then
  source $HOME/.variables
fi

if [ -f "$HOME/.functions" ]; then
  source $HOME/.functions
fi


if [ -f "$HOME/.fzf.zsh" ]; then
  source ~/.fzf.zsh
fi
# BEGIN ANSIBLE MANAGED BLOCK tmuxinator.zsh
TMUXINATOR_COMPLETION_FILE="/home/kalvatn/.tmuxinator/completion/tmuxinator.zsh"
if [ -f "$TMUXINATOR_COMPLETION_FILE" ]; then
  source "$TMUXINATOR_COMPLETION_FILE"
fi
# END ANSIBLE MANAGED BLOCK tmuxinator.zsh
