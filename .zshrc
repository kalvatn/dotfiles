# Path to your oh-my-zsh installation.
export ZSH=/home/kalvatn/.oh-my-zsh

ZSH_THEME="kalvatn"
plugins=(git svn vi-mode)

# User configuration

bindkey -v
bindkey '^r' history-incremental-search-backward


export PATH="/home/kalvatn/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# ssh
export SSH_KEY_PATH="~/.ssh/id_rsa"

[[ -f $HOME/.aliases ]] && source $HOME/.aliases
[[ -f $HOME/.variables ]] && source $HOME/.variables


# use vim as pager
export PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
vim -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' \
-c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
-c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""


#export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""
