#!/bin/bash
cpluspalette /home/psyamen/ 9 -m > /home/psyamen/.config/waybar/colors.txt
sed -i 's/\x0//g' /home/psyamen/.config/waybar/colors.txt

#color=$(sed -n '2p' /home/psyamen/.config/waybar/colors.txt)
#r=$((0x${color:1:2})); g=$((0x${color:3:2})); b=$((0x${color:5:2}))
#sed -i '121s|.*|background-color:rgba('"$r"','"$g"','"$b"',0.5);|' /home/psyamen/.config/waybar/#style.css

color=$(sed -n '3p' /home/psyamen/.config/waybar/colors.txt)
r=$((0x${color:1:2})); g=$((0x${color:3:2})); b=$((0x${color:5:2}))
sed -i '127s|.*|background-color:rgba('"$r"','"$g"','"$b"',0.5);|' /home/psyamen/.config/waybar/style.css

color=$(sed -n '4p' /home/psyamen/.config/waybar/colors.txt)
r=$((0x${color:1:2})); g=$((0x${color:3:2})); b=$((0x${color:5:2}))
sed -i '242s|.*|background-color:rgba('"$r"','"$g"','"$b"',0.5);|' /home/psyamen/.config/waybar/style.css

color=$(sed -n '5p' /home/psyamen/.config/waybar/colors.txt)
r=$((0x${color:1:2})); g=$((0x${color:3:2})); b=$((0x${color:5:2}))
sed -i '184s|.*|background-color:rgba('"$r"','"$g"','"$b"',0.5);|' /home/psyamen/.config/waybar/style.css

color=$(sed -n '6p' /home/psyamen/.config/waybar/colors.txt)
r=$((0x${color:1:2})); g=$((0x${color:3:2})); b=$((0x${color:5:2}))
sed -i '178s|.*|background-color:rgba('"$r"','"$g"','"$b"',0.5);|' /home/psyamen/.config/waybar/style.css

color=$(sed -n '7p' /home/psyamen/.config/waybar/colors.txt)
r=$((0x${color:1:2})); g=$((0x${color:3:2})); b=$((0x${color:5:2}))
sed -i '199s|.*|background-color:rgba('"$r"','"$g"','"$b"',0.5);|' /home/psyamen/.config/waybar/style.css

color=$(sed -n '8p' /home/psyamen/.config/waybar/colors.txt)
r=$((0x${color:1:2})); g=$((0x${color:3:2})); b=$((0x${color:5:2}))
sed -i '208s|.*|background-color:rgba('"$r"','"$g"','"$b"',0.5);|' /home/psyamen/.config/waybar/style.css

color=$(sed -n '9p' /home/psyamen/.config/waybar/colors.txt)
r=$((0x${color:1:2})); g=$((0x${color:3:2})); b=$((0x${color:5:2}))
sed -i '250s|.*|background-color:rgba('"$r"','"$g"','"$b"',0.5);|' /home/psyamen/.config/waybar/style.css

color=$(sed -n '10p' /home/psyamen/.config/waybar/colors.txt)
r=$((0x${color:1:2})); g=$((0x${color:3:2})); b=$((0x${color:5:2}))
sed -i '61s|.*|background-color:rgba('"$r"','"$g"','"$b"',0.4);|' /home/psyamen/.config/waybar/style.css

#color=$(sed -n '11p' /home/psyamen/.config/waybar/colors.txt)
#r=$((0x${color:1:2})); g=$((0x${color:3:2})); b=$((0x${color:5:2}))
sed -i '66s|.*|background-color:rgba('"$r"','"$g"','"$b"',0.7);|' /home/psyamen/.config/waybar/style.css
sed -i '70s|.*|background-color:rgba('"$r"','"$g"','"$b"',0.7);|' /home/psyamen/.config/waybar/style.css

#66,70 61 121 127 242 184 176 199 208 250
