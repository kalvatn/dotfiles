#!/bin/bash

spellcheck_word() {
  # pipe word(s) to aspell and omit first line of result
  spelling="$(echo "$@" | aspell -a | sed -n '1!p')"
  correct=true
  for i in $(echo "$spelling" | tr "\r" "\n"); do
    if [ "$i" != "*" ]; then
      correct=false
      break
    fi
  done
  if ! $correct; then
    echo "'$*' is incorrectly spelled"
    echo "$spelling"
  else
    echo "'$*' is correctly spelled"
  fi
}

lookup_word() {
  sdcv -0cn "$@" | less -XFR
}

spellcheck_and_lookup_word() {
  spellcheck_word "$@"
  lookup_word "$@"
}

alias dict=lookup_word
alias spell=spellcheck_word
alias spelldict=spellcheck_and_lookup_word
