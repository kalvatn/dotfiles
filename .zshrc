# Path to your oh-my-zsh installation.
export ZSHRC=/home/kalvatn/.zshrc
export ZSH=/home/kalvatn/.oh-my-zsh

autoload -U colors zsh-mime-setup select-word-style
colors          # colors
zsh-mime-setup  # run everything as if it's an executable
select-word-style bash # ctrl+w on words

ZSH_THEME="kalvatn"
plugins=(git svn vi-mode)

# User configuration

bindkey -v
bindkey '\e[3~'   delete-char             # Del
bindkey '\e[5~'   history-search-backward # PgUp
bindkey '\e[6~'   history-search-forward  # PgDn
bindkey '^A'      beginning-of-line       # Home
bindkey '^R'      history-incremental-pattern-search-backward
#bindkey '^r' history-incremental-search-backward

##
# Completion
##
autoload -U compinit
compinit
zmodload -i zsh/complist
setopt hash_list_all            # hash everything before completion
setopt completealiases          # complete alisases
setopt always_to_end            # when completing from the middle of a word, move the cursor to the end of the word
setopt complete_in_word         # allow completion from within a word/phrase
setopt correct                  # spelling correction for commands
setopt list_ambiguous           # complete as much of a completion until it gets ambiguous.
setopt hist_allow_clobber
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_no_store
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt extended_history
setopt inc_append_history

zstyle ':completion::complete:*' use-cache on               # completion caching, use rehash to clear
zstyle ':completion:*' cache-path ~/.zsh/cache              # cache path
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'   # ignore case
zstyle ':completion:*' menu select=2                        # menu if nb items > 2
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}       # colorz !
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate # list of completers to use

# sections completion !
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format $'\e[00;34m%d'
zstyle ':completion:*:messages' format $'\e[00;31m%d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:manuals' separate-sections true

zstyle ':completion:*:processes' command 'ps -au$USER'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=29=34"
zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*' force-list always
users=(jvoisin root)           # because I don't care about others
zstyle ':completion:*' users $users

#generic completion with --help
compdef _gnu_generic gcc
compdef _gnu_generic gdb

##
# Pushd
##
setopt auto_pushd               # make cd push old dir in dir stack
setopt pushd_ignore_dups        # no duplicates in dir stack
setopt pushd_silent             # no dir stack after pushd or popd
setopt pushd_to_home            # `pushd` = `pushd $HOME`
#
##
# History
##
export HISTCONTROL=ignoredups:erasedups
HISTFILE=~/.zsh_history         # where to store zsh config
HISTSIZE=20000                   # big history
SAVEHIST=20000                   # big history
setopt append_history           # append
setopt hist_ignore_all_dups     # no duplicate
#unsetopt hist_ignore_space      # ignore space prefixed commands
setopt hist_reduce_blanks       # trim blanks
setopt hist_verify              # show before executing history commands
setopt inc_append_history       # add commands as they are typed, don't wait until shell exit
setopt share_history            # share hist between sessions
setopt bang_hist                # !keyword

export PATH="/home/kalvatn/bin:/home/kalvatn/workbin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# ssh
export SSH_KEY_PATH="~/.ssh/id_rsa"

[[ -f $HOME/.aliases ]] && source $HOME/.aliases
[[ -f $HOME/.variables ]] && source $HOME/.variables
[[ -f $HOME/.functions ]] && source $HOME/.functions


export EDITOR='vim'

# use vim as pager
export PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
vim -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' \
-c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
-c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""


#export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""

# -X (--no-init) -F (--quit-if-one-screen) -R (--RAW-CONTROL-CHARS)
export LESS="-XFR"

export NVM_DIR="/home/kalvatn/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
source /home/kalvatn/.tmuxinator/completion/tmuxinator.zsh
