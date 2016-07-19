#!/usr/bin/env zsh


set -e

# see https://github.com/sorin-ionescu/prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
	ln -sf "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
