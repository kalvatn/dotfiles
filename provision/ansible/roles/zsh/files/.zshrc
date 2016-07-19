#!/usr/bin/env zsh

[[ "$COLORTERM" == "gnome-terminal" ]] && export TERM="xterm-256color"

autoload -U colors zsh-mime-setup select-word-style
colors          # colors
zsh-mime-setup  # run everything as if it's an executable
select-word-style bash # ctrl+w on words
