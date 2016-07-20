#!/usr/bin/env zsh

# see https://github.com/sorin-ionescu/prezto
set -e


ZPRESTO_HOME="${ZDOTDIR:-$HOME}/.zpresto"

git clone --recursive https://github.com/sorin-ionescu/prezto.git "$ZPRESTO_HOME"

cd $ZPRESTO_HOME
git pull && git submodule update --init --recursive

setopt EXTENDED_GLOB
for rcfile in $ZPRESTO_HOME/runcoms/^README.md(.N); do
	ln -sf "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
