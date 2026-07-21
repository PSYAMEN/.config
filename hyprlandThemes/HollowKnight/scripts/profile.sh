#!/bin/bash

CONFIG_DIR="$HOME/.config/hypr"
THEME_FOLDER="$1"
killall qs mpvpaper
rm -rf /tmp/mpvpaper-*
if [ -z "$THEME_FOLDER" ]; then
    echo "Usage: $0 <theme-folder>"
    exit 1
fi

# Allow either absolute paths or theme names inside ~/.config/hyprlandThemes
if [ ! -d "$THEME_FOLDER" ]; then
    THEME_FOLDER="$HOME/.config/hyprlandThemes/$THEME_FOLDER"
fi

if [ ! -d "$THEME_FOLDER" ]; then
    echo "Theme folder not found: $THEME_FOLDER"
    exit 1
fi

rm -rf "$CONFIG_DIR"/hyprland.*
rm -rf /tmp/mpvpaper-*
killall qs mpvpaper
if [ -f "$THEME_FOLDER/hyprland.conf" ]; then
    target_file="$THEME_FOLDER/hyprland.conf"
    ln -sfn "$target_file" "$CONFIG_DIR/hyprland.conf"
    killall Hyprland
    hyprland -c "$target_file"

elif [ -f "$THEME_FOLDER/hyprland.lua" ]; then
    target_file="$THEME_FOLDER/hyprland.lua"
    ln -sfn "$target_file" "$CONFIG_DIR/hyprland.lua" 
    killall qs mpvpaper
    rm -rf /tmp/mpvpaper-*
    hyprctl reload
else
    echo "No hyprland.conf or hyprland.lua found in $THEME_FOLDER"
    exit 1
fi
