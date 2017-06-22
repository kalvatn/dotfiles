#!/usr/bin/env bash

export PATH="$PATH:/usr/local/bin"

echo "$(date)"
SLEEPTIME=10
monitor() {
  local pid=$1 i=0
  while ps "$pid" &>/dev/null; do
    if (( i++ > 10 )); then
      echo "max checks reached, sending SIGKILL to ${pid}"
      kill -9 "$pid"
      return 1
    fi
    sleep $SLEEPTIME
  done
  return 0
}

pid="$(pgrep offlineimap)"
if [ ! -z "$pid" ]; then
  echo "offlineimap already running (pid : $pid), exiting"
  exit 1
fi

sessionfile="$(find "${HOME}/.dbus/session-bus/" -type f)"
export "$(grep ^DBUS_SESSION_BUS_ADDRESS "$sessionfile")"
#echo "DBUS_SESSION_BUS_ADDRESS : $DBUS_SESSION_BUS_ADDRESS"

offlineimap -q -o -u quiet & monitor "$!"

# stolen from https://github.com/natmey/dotfiles/blob/master/notmuch/notmuch-post-sync

notmuch new
notmuch tag -unread -- from:j.kalvatn@sportradar.com
notmuch tag -unread -- from:jonterje.kalvatn@gmail.com

notmuch tag +intranet -- from:intranet@sportradar.com
notmuch tag +timesystem -- from:timesystem@sportradar.com
notmuch tag +jira -- from:jira@sportradar.com

NOTIFICATION_ICON=/usr/share/icons/HighContrast/32x32/status/mail-unread.png
SEARCH="tag:unread"
#LIMIT=3
# SORT="newest-first"

UNREAD_COUNT=$(notmuch count --output=threads "$SEARCH")
if [ "$UNREAD_COUNT" -gt 0 ]; then
  # TXT_SUBS=$(notmuch search --format=text --output=summary --limit="$LIMIT" --sort="$SORT" "$SEARCH" | sed 's/^[^;]*; //' | sed 's/$/\n'/)
  # HTML_SUBS=$(echo "$TXT_SUBS" | recode UTF-8..html)
  # notify-send -i "$NOTIFICATION_ICON" "$UNREAD_COUNT unread mesages." "$HTML_SUBS"
  # notify-send -t 1 -u low -i "$NOTIFICATION_ICON" "$UNREAD_COUNT unread emails."
  exit 0
fi
echo "mailsync finished $(date +"%Y-%m-%d %H:%M:%S")"
exit 0
