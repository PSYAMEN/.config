#!/bin/bash
folder="/home/$USER/.config/hyprlandThemes"
mapfile -t themes < <(find "$folder" -mindepth 1 -maxdepth 1 -type d -printf "%f\t%p\n")
selected=$(printf '%s\n' "${themes[@]}" | cut -f1 | rofi -dmenu -theme ~/.config/hyprlandThemes/NoOneWillKnow/rofiThemes/menu.rasi -i -p "Themes")
if [ -n "$selected" ]; then
  full_path=$(printf '%s\n' "${themes[@]}" | grep -F "$selected" | cut -f2 -d$'\t')
  sed -i '1s|.*|source= '"${full_path}/hyprland.conf"'|' ~/.config/hypr/hyprland.conf 
  hyprctl reload
fi
