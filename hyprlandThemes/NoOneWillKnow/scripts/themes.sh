#!/bin/bash

folder="/home/$USER/.config/hyprlandThemes"
CONFIG_DIR="$HOME/.config/hypr"

mapfile -t themes < <(find "$folder" -mindepth 1 -maxdepth 1 -type d -printf "%f\t%p\n")

selected=$(printf '%s\n' "${themes[@]}" | cut -f1 | rofi \
    -dmenu \
    -theme ~/.config/hyprlandThemes/NoOneWillKnow/rofiThemes/menu.rasi \
    -i \
    -p "Themes"
)

killall hyprpaper 
killall waybar 
killall qs
if [ -n "$selected" ]; then
    full_path=$(printf '%s\n' "${themes[@]}" | grep -F "$selected" | cut -f2 -d$'\t')

    rm -rf "$CONFIG_DIR"/hyprland.*
    killall hyprpaper waybar qs
    if [ -f "$full_path/hyprland.conf" ]; then
        target_file="$full_path/hyprland.conf"

        ln -sfn "$target_file" "$HOME/.config/hypr/hyprland.conf"

        killall Hyprland
        hyprland -c "$target_file"

    elif [ -f "$full_path/hyprland.lua" ]; then
        target_file="$full_path/hyprland.lua"
	
    	killall hyprpaper waybar qs quickshell
        ln -sfn "$target_file" "$HOME/.config/hypr/hyprland.lua"

    	killall hyprpaper waybar qs quickshell
        hyprctl reload
    fi
fi
