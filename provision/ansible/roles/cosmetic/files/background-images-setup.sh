#!/bin/bash

set -e
source "$HOME/.config/user-dirs.dirs"

ZIP_FILE="$XDG_DOWNLOAD_DIR/background-images.zip"
ZIP_URL="https://dl.dropboxusercontent.com/u/535060/chromecast1080_4.zip"
TARGET_FOLDER="$XDG_PICTURES_DIR/background_images"

function download() {
  echo "(resuming) download '$ZIP_URL' -> '$ZIP_FILE'"
  curl -L -C - "$ZIP_URL" -o "$ZIP_FILE"
}

if [ -f "$ZIP_FILE" ]; then
  echo "file '$ZIP_FILE' already exists, checking size"
  local_size="$(stat -c"%s" "$ZIP_FILE")"
  remote_size="$(curl -s -L -I "$ZIP_URL" | grep "^Content\-Length: " | cut -d ' ' -f2 | tr -d '\r')"

  if [ "$local_size" != "$remote_size" ]; then
    echo "local_size : '$local_size' != remote_size : '$remote_size'"
    download
  fi
else
  download
fi
mkdir -p "$TARGET_FOLDER"
echo "extracting '$ZIP_FILE' to '$TARGET_FOLDER'"
unzip -q -n "$ZIP_FILE" -d "$TARGET_FOLDER"


if [ ! -z "$DISPLAY" ]; then
  BACKGROUND_IMAGE_LINK="$HOME/.current-desktop-background"

  echo "allow lightdm to connect to x"
  sudo xhost +SI:localuser:lightdm > /dev/null 2>&1

  echo "set lightdm background settings"
  sudo su lightdm -s /bin/bash <<EOM
gsettings set com.canonical.unity-greeter draw-user-backgrounds 'false' #eliminates display of other users wallpaper at login
gsettings set com.canonical.unity-greeter background '$BACKGROUND_IMAGE_LINK' #set login wallpaper
gsettings set com.canonical.unity-greeter draw-grid 'false' #removes dots on background
gsettings set com.canonical.unity-greeter background-color '#000000' #eliminates purple screen before background loads
exit
EOM
fi
