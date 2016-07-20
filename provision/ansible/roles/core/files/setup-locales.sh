#!/bin/bash

set -e

if [[ $EUID -ne 0 ]]; then
   echo "this script must be run as root"
   exit 1
fi

LOCALE_EN=en_US.UTF-8
LOCALE_NO=nb_NO.UTF-8

export LANG=$LOCALE_EN
export LANGUAGE=en_US
export LC_CTYPE=$LOCALE_EN
export LC_NUMERIC=$LOCALE_NO
export LC_TIME=$LOCALE_NO
export LC_COLLATE="$LOCALE_EN"
export LC_MONETARY=$LOCALE_NO
export LC_MESSAGES="$LOCALE_EN"
export LC_PAPER=$LOCALE_NO
export LC_NAME=$LOCALE_NO
export LC_ADDRESS=$LOCALE_NO
export LC_TELEPHONE=$LOCALE_NO
export LC_MEASUREMENT=$LOCALE_NO
export LC_IDENTIFICATION=$LOCALE_NO
export LC_ALL=

locale-gen $LOCALE_EN
locale-gen $LOCALE_NO

dpkg-reconfigure locales
