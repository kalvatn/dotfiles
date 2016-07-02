#!/bin/bash

set -e

source "$HOME/.functions"
CWD="$(get_script_dir "$0")"

DICT_DIR=/usr/share/stardict/dic
TMP_DICT_DIR=/tmp/dicts
if [ ! -d "$DICT_DIR" ]; then
  sudo mkdir -p "$DICT_DIR"
fi
mkdir -p "$TMP_DICT_DIR"

if needs_install sdcv; then
  # stardict console version (http://sdcv.sourceforge.net/)
  apt_install sdcv
fi

if [ ! -d "$DICT_DIR/stardict-dictd_www.dict.org_gcide-2.4.2" ]; then
  # CIDE (https://en.wikipedia.org/wiki/Collaborative_International_Dictionary_of_English)
  if [ ! -f "$TMP_DICT_DIR/cide.tar.bz2" ]; then
    info "downloading CIDE dict"
    curl -L "https://web.archive.org/web/20140917131745/http://abloz.com/huzheng/stardict-dic/dict.org/stardict-dictd_www.dict.org_gcide-2.4.2.tar.bz2" -o "$TMP_DICT_DIR/cide.tar.bz2"
  fi
  sudo tar xvjf "$TMP_DICT_DIR/cide.tar.bz2" -C "$DICT_DIR"
else
  debug "CIDE dict already installed"
fi

if [ ! -d "$DICT_DIR/stardict-dictd_www.dict.org_gcide-2.4.2" ]; then
  # GNU Linux English-English
  if [ ! -f "$TMP_DICT_DIR/gnu-linux.tar.bz2" ]; then
    info "downloading CIDE dict"
    curl -L "http://abloz.com/huzheng/stardict-dic/misc/stardict-xfardic-gnu-linux-2.4.2.tar.bz2" -o "$TMP_DICT_DIR/gnu-linux.tar.bz2"
  fi
  sudo tar xvjf "$TMP_DICT_DIR/gnu-linux.tar.bz2" -C "$DICT_DIR"
else
  debug "GNU Linux English-English dict already installed"
fi

test_dict="$(sdcv -0cn "dictionary")"
if [ "$test_dict" == "Nothing similar to dictionary, sorry :(" ]; then
  error "dictionaries not installed correctly"
  exit 1
fi
append_line_to_file "source $CWD/aliases" "$HOME/.aliases"

