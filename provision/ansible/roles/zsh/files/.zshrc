#!/usr/bin/env zsh

[[ "$COLORTERM" == "gnome-terminal" ]] && export TERM="xterm-256color"

# BEGIN ANSIBLE MANAGED BLOCK
ZPREZTO_INIT_FILE="${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
if [ -s "$ZPREZTO_INIT_FILE" ]; then
  source "$ZPREZTO_INIT_FILE"
fi
# END ANSIBLE MANAGED BLOCK

# autoload -Uz promptinit
# promptinit
# prompt kalvatn

autoload -U compinit
compinit
zmodload -i zsh/complist

autoload -Uz colors zsh-mime-setup #select-word-style
# colors          # colors
# zsh-mime-setup  # run everything as if it's an executable
# select-word-style bash # ctrl+w on words
# autoload predict-on
# predict-toggle() {
#   ((predict_on=1-predict_on)) && predict-on || predict-off
# }
# zle -N predict-toggle
# bindkey '^Z'   predict-toggle
# zstyle ':predict' toggle true
# zstyle ':predict' verbose true




bindkey -v
bindkey -M vicmd 'v' edit-command-line

autoload -Uz edit-command-line

# # if mode indicator wasn't setup by theme, define default
# if [[ "$MODE_INDICATOR" == "" ]]; then
#   MODE_INDICATOR="%{$fg_bold[red]%}<%{$fg[red]%}<<%{$reset_color%}"
# fi

# function vi_mode_prompt_info() {
#   echo "${${KEYMAP/vicmd/$MODE_INDICATOR}/(main|viins)/}"
# }

# define right prompt, if it wasn't defined by a theme
# if [[ "$RPS1" == "" && "$RPROMPT" == "" ]]; then
#   RPS1='$(vi_mode_prompt_info)'
# fi


# Ensure that the prompt is redrawn when the terminal size changes.
TRAPWINCH() {
  zle && { zle reset-prompt; zle -R }
}
# use cursor as indicator of vi mode
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
zle -N zle-keymap-select
export KEYTIMEOUT=1

setopt hash_list_all            # hash everything before completion
setopt completealiases          # complete alisases
setopt always_to_end            # when completing from the middle of a word, move the cursor to the end of the word
setopt complete_in_word         # allow completion from within a word/phrase
setopt list_ambiguous           # complete as much of a completion until it gets ambiguous.

unsetopt correct
unsetopt correct_all

zstyle ':completion::complete:*' use-cache on               # completion caching, use rehash to clear
zstyle ':completion:*' cache-path ~/.zsh/cache              # cache path
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'   # ignore case
zstyle ':completion:*' menu select=2                        # menu if nb items > 2
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate # list of completers to use

zstyle ':completion:*' verbose yes
# zstyle ':completion:*:descriptions' format $'\e[00;34m%d'
# zstyle ':completion:*:messages' format $'\e[00;31m%d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:manuals' separate-sections true

# zstyle ':completion:*:processes' command 'ps -au$USER'
# zstyle ':completion:*:*:kill:*' menu yes select
# zstyle ':completion:*:kill:*' force-list always
# zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=29=34"
# zstyle ':completion:*:*:killall:*' menu yes select
# zstyle ':completion:*:killall:*' force-list always

# compdef _gnu_generic gcc
# compdef _gnu_generic gdb

setopt auto_pushd               # make cd push old dir in dir stack
setopt pushd_ignore_dups        # no duplicates in dir stack
setopt pushd_silent             # no dir stack after pushd or popd
setopt pushd_to_home            # `pushd` = `pushd $HOME`

export HISTCONTROL=ignoredups:erasedups
export HISTFILE=~/.zsh_history         # where to store zsh config
export HISTSIZE=20000                   # big history
export SAVEHIST=20000                   # big history
setopt hist_ignore_dups
setopt hist_ignore_all_dups     # no duplicate
setopt hist_allow_clobber
setopt hist_ignore_space
setopt hist_no_store
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt extended_history
setopt hist_reduce_blanks       # trim blanks
setopt hist_verify              # show before executing history commands
setopt append_history           # append
setopt inc_append_history       # add commands as they are typed, don't wait until shell exit
setopt share_history            # share hist between sessions
setopt bang_hist                # !keyword


export EDITOR='vim'
export VISUAL='vim'
if command -v nvim > /dev/null; then
  export EDITOR='nvim'
  export VISUAL='nvim'
fi

if command -v vim > /dev/null; then
  # use vim as pager
  # export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""
  export PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
vim -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' \
-c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
-c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""
fi

# -X (--no-init) -F (--quit-if-one-screen) -R (--RAW-CONTROL-CHARS)
export LESS="-XFR"

export PATH="$HOME/bin:$HOME/workbin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

if [ -f "$HOME/.aliases" ]; then
  echo "sourcing aliases"
  source $HOME/.aliases
fi

if [ -f "$HOME/.variables" ]; then
  echo "sourcing variables"
  source $HOME/.variables
fi

if [ -f "$HOME/.functions" ]; then
  echo "sourcing functions"
  source $HOME/.functions
fi


if [ -f ~/.fzf.zsh ]; then
  echo "sourcing ~/.fzf.zsh"
  source ~/.fzf.zsh
fi
