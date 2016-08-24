#!/bin/bash

set -e

source "$HOME/.config/user-dirs.dirs"
BACKGROUND_IMAGE_FOLDER="$XDG_PICTURES_DIR/background_images"

if [ ! -d "$BACKGROUND_IMAGE_FOLDER" ]; then
  echo "background image folder '$BACKGROUND_IMAGE_FOLDER' not found"
  exit 1
fi

if [ -z "$1" ]; then
  image_file="$(find "$XDG_PICTURES_DIR/background_images" -type f -iname '*.png' -o -type f -iname '*.jpg' | shuf -n1)"
else
  image_file="$1"
fi

if [ ! -f "$image_file" ]; then
  echo "image file '$image_file' not found"
  exit 1
fi

BACKGROUND_IMAGE_LINK="$HOME/.current-desktop-background"
ln -sf "$image_file" "$BACKGROUND_IMAGE_LINK"
feh --no-fehbg --bg-fill "$image_file"
