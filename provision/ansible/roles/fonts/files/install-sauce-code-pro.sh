#!/bin/bash

set -e

FONT_DIR="/usr/share/fonts/truetype/sourcecodepro"
FONT_FILE="Sauce Code Pro Medium Nerd Font Complete Mono.ttf"
FONT_SIZE="10"
if [ ! -f "$FONT_DIR/$FONT_FILE" ]; then
  if [ ! -d "$FONT_DIR" ]; then
    sudo mkdir -p "$FONT_DIR"
  fi
  info "downloading '$FONT_URL' -> '$FONT_DIR/$FONT_FILE'"
  FONT_URL="https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/Medium/complete/$FONT_FILE?raw=true"
  sudo curl -s -L "${FONT_URL// /%20}" -o "$FONT_DIR/$FONT_FILE"
  info "updating font-cache"
  sudo fc-cache -rf
fi
FONT_NAME="$(fc-query "$FONT_DIR/$FONT_FILE" -f "%{family} %{style}\n")"

# fix potential broken dbus session environment
sessionfile="$(find "${HOME}/.dbus/session-bus/" -type f)"
export "$(grep ^DBUS_SESSION_BUS_ADDRESS "$sessionfile")"
gconftool-2 --set /apps/gnome-terminal/profiles/Default/use_system_font --type=boolean false
gconftool-2 --set /apps/gnome-terminal/profiles/Default/font --type string "$FONT_NAME $FONT_SIZE"

for profile_id in $(dconf list "/org/gnome/terminal/legacy/profiles:/"); do
  info "setting font to '$FONT_NAME $FONT_SIZE' for profile_id : $profile_id"

  dconf write "/org/gnome/terminal/legacy/profiles:/${profile_id}font" "'$FONT_NAME $FONT_SIZE'"
  dconf write "/org/gnome/terminal/legacy/profiles:/${profile_id}use-system-font" "false"
done
