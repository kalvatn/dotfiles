#!/bin/bash

#set -e

touch /tmp/last_fm_last_scrobble

function now_playing_spotify() {
  spotifyctrl NowPlaying
}

function now_playing_last_fm() {
    #last_fm_np=$(create_element "last_fm_np" "lastfm" "$(now_playing_last_fm)" "#FF00FF")
    track=$(cat /tmp/last_fm_last_scrobble)
    if test "$(find "/tmp/last_fm_last_scrobble" -mmin +2)"; then
        track=$(curl -s http://ws.audioscrobbler.com/2.0/user/chauney/recenttracks.rss | xmlstarlet sel -T -t -m '//item[1]/title/text()' -v '.' -n)
        echo "$track" > /tmp/last_fm_last_scrobble
    fi
    echo "last scrobble : $track"
}

function create_element() {
    name=$1
    instance=$2
    text=$3
    color=$4
    echo "{\"name\":\"$name\",\"instance\":\"$instance\",\"full_text\":\"$text\",\"color\":\"$color\"}"
}

i3status --config "$1" | (read line && echo "$line" && read line && echo "$line" && while :
do
    read line
    startchr="$(expr index "$line" C[)"
    prefix=${line:0:${startchr}}
    line="${line:${startchr}:${#line}-${startchr}-1}"

    #last_fm_np=$(create_element "last_fm_np" "lastfm" "$(now_playing_last_fm)" "#FF00FF")
    spotify_np=$(create_element "spotify_np" "spotify" "$(now_playing_spotify)" "#FF00FF")
    echo "$prefix $spotify_np, $line ]" # || exit 1

done)
