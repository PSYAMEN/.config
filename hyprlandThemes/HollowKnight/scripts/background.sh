#!/usr/bin/env bash

echo "argc=$#"

i=1
for arg in "$@"; do
    echo "$i=<$arg>"
    ((i++))
done

# Last argument is the wallpaper
wallpaper="${@: -1}"

echo "$wallpaper" > ~/.config/hyprlandThemes/HollowKnight/mpvplayer/saveBG

# Remove wallpaper from arguments
set -- "${@:1:$#-1}"

while [ "$#" -gt 0 ]; do
    monitor="$1"
    aspect="$2"

    socket="/tmp/mpvpaper-$monitor.sock"

    echo "Monitor: $monitor"
    echo "Aspect: $aspect"
    echo "Wallpaper: $wallpaper"

    # If mpvpaper is already running for this monitor, switch wallpaper
    if [ -S "$socket" ]; then
        echo "Switching existing wallpaper on $monitor"

        echo '{ "command": ["loadfile", "'"$wallpaper"'", "replace"] }' \
            | socat - "$socket"

    else
        echo "Starting mpvpaper on $monitor"

        nohup mpvpaper "$monitor" \
            -o "--loop --panscan=1.0 --input-ipc-server=$socket" \
            "$wallpaper" \
            >/tmp/mpvpaper-$monitor.log 2>&1 &
    fi

    shift 2
done
