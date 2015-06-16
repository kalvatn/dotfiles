# Path to your oh-my-zsh installation.
export ZSH=/home/kalvatn/.oh-my-zsh

ZSH_THEME="kalvatn"
plugins=(git vi-mode)

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
