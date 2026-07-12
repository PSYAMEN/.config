#!/bin/bash
folder="~/.config/hyprlandThemes"
mapfile -t themes < <(find "$folder" -type f \( -iname "*.conf" \) -printf "%f\t%p\n")
selected=$(printf '%s\n' "${themes[@]}" | cut -f1 | rofi -dmenu -theme ~/.config/rofi/themes/blue2.rasi -i -p "Themes")
if [ -n "$selected" ]; then
  full_path=$(printf '%s\n' "${themes[@]}" | grep -F "$selected" | cut -f2 -d$'\t')
  sed -i '1s|.*|source= '"$full_path"'|' ~/.config/hypr/hyprland.conf 
  hyprctl reload
  killall waybar
  waybar
fi
