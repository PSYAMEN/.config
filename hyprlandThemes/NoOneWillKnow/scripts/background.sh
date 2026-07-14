#!/bin/bash
folder="/home/$USER/.config/hyprlandThemes/NoOneWillKnow/Backgrounds/"
mapfile -t wallpapers < <(find "$folder" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.gif" -o -iname "*.webp" \) -printf "%f\t%p\n")
selected=$(printf '%s\n' "${wallpapers[@]}" | cut -f1 | rofi -dmenu -theme ~/.config/hyprlandThemes/NoOneWillKnow/rofiThemes/menu.rasi -i -p "Backgrounds")
if [ -n "$selected" ]; then
  full_path=$(printf '%s\n' "${wallpapers[@]}" | grep -F "$selected" | cut -f2 -d$'\t')
  sed -i '3s|.*|    path = '"${folder}/${selected}"'|' ~/.config/hypr/hyprpaper.conf
  sed -i '9s|.*|    path = '"${folder}/$selected"'|' ~/.config/hypr/hyprpaper.conf
  killall hyprpaper
  hyprpaper & sleep 1 && kitty +kitten panel --config=~/.config/kitty/kittyl.conf --edge=background -o background_opacity=0 -o background=black sh -c "printf \"\n\n\n\"; hyfetch; printf \"\e[?25l\"; sleep infinity" >/dev/null 2>&1 < /dev/null &
fi
