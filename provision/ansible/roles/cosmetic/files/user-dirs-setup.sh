#!/bin/bash

set -e

source "$HOME/.config/user-dirs.dirs"

mkdir -p "$XDG_DESKTOP_DIR"
mkdir -p "$XDG_DOWNLOAD_DIR"
mkdir -p "$XDG_TEMPLATES_DIR"
mkdir -p "$XDG_PUBLICSHARE_DIR"
mkdir -p "$XDG_DOCUMENTS_DIR"
mkdir -p "$XDG_MUSIC_DIR"
mkdir -p "$XDG_PICTURES_DIR"
mkdir -p "$XDG_VIDEOS_DIR"

[[ -f "$HOME/examples.desktop" ]] && rm "$HOME/examples.desktop"
[[ -d "$HOME/Desktop" ]] && mv -T "$HOME/Desktop" "$XDG_DESKTOP_DIR"
[[ -d "$HOME/Documents" ]] && mv -T "$HOME/Documents" "$XDG_DOCUMENTS_DIR"
[[ -d "$HOME/Templates" ]] && mv -T "$HOME/Templates" "$XDG_TEMPLATES_DIR"
[[ -d "$HOME/Downloads" ]] && mv -T "$HOME/Downloads" "$XDG_DOWNLOAD_DIR"
[[ -d "$HOME/Music" ]] && mv -T "$HOME/Music" "$XDG_MUSIC_DIR"
[[ -d "$HOME/Pictures" ]] && mv -T "$HOME/Pictures" "$XDG_PICTURES_DIR"
[[ -d "$HOME/Videos" ]] && mv -T "$HOME/Videos" "$XDG_VIDEOS_DIR"
[[ -d "$HOME/Public" ]] && mv -T "$HOME/Public" "$XDG_PUBLICSHARE_DIR"

xdg-user-dirs-update
