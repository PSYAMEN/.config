#!/bin/bash
folder="/home/psyamen/Backgrounds/"
mapfile -t wallpapers < <(find "$folder" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.gif" -o -iname "*.webp" \) -printf "%f\t%p\n")
selected=$(printf '%s\n' "${wallpapers[@]}" | cut -f1 | rofi -dmenu -theme ~/.config/rofi/themes/blue2.rasi -i -p "Backgrounds")
if [ -n "$selected" ]; then
  full_path=$(printf '%s\n' "${wallpapers[@]}" | grep -F "$selected" | cut -f2 -d$'\t')
  sed -i '3s|.*|    path = /home/psyamen/Backgrounds/'"$selected"'|' /home/psyamen/.config/hypr/hyprpaper.conf
  sed -i '9s|.*|    path = /home/psyamen/Backgrounds/'"$selected"'|' /home/psyamen/.config/hypr/hyprpaper.conf
  killall hyprpaper
  hyprpaper & sleep 1 && kitty +kitten panel --config=home/psyamen/.config/kitty/kittyl.conf --edge=background -o background_opacity=0 -o background=black sh -c "printf \"\n\n\n\"; hyfetch; printf \"\e[?25l\"; sleep infinity" >/dev/null 2>&1 < /dev/null &
fi
