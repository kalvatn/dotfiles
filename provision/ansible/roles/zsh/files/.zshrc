#!/usr/bin/env zsh

[[ "$COLORTERM" == "gnome-terminal" ]] && export TERM="xterm-256color"

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

autoload -Uz promptinit
promptinit
# prompt agnoster
prompt kalvatn

autoload -U compinit
compinit
# zmodload -i zsh/complist

# autoload -U colors zsh-mime-setup select-word-style
# colors          # colors
# zsh-mime-setup  # run everything as if it's an executable
# select-word-style bash # ctrl+w on words

bindkey -v
bindkey '\e[3~'   delete-char             # Del
bindkey '\e[5~'   history-search-backward # PgUp
bindkey '\e[6~'   history-search-forward  # PgDn
bindkey '^A'      beginning-of-line       # Home
bindkey '^R'      history-incremental-pattern-search-backward

setopt hash_list_all            # hash everything before completion
setopt completealiases          # complete alisases
setopt always_to_end            # when completing from the middle of a word, move the cursor to the end of the word
setopt complete_in_word         # allow completion from within a word/phrase
setopt list_ambiguous           # complete as much of a completion until it gets ambiguous.
unsetopt correct_all

zstyle ':completion::complete:*' use-cache on               # completion caching, use rehash to clear
zstyle ':completion:*' cache-path ~/.zsh/cache              # cache path
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'   # ignore case
zstyle ':completion:*' menu select=2                        # menu if nb items > 2
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}       # colorz !
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate # list of completers to use

# zstyle ':completion:*' verbose yes
# zstyle ':completion:*:descriptions' format $'\e[00;34m%d'
# zstyle ':completion:*:messages' format $'\e[00;31m%d'
# zstyle ':completion:*' group-name ''
# zstyle ':completion:*:manuals' separate-sections true

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

if command -v nvim > /dev/null; then
  export EDITOR='nvim'
elif command -v vim > /dev/null; then
  export EDITOR='vim'
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

[[ -f $HOME/.aliases   ]] && source $HOME/.aliases
[[ -f $HOME/.variables ]] && source $HOME/.variables
[[ -f $HOME/.functions ]] && source $HOME/.functions



[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
