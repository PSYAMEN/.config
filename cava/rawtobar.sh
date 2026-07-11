#!/bin/bash
bars=▁▂▃▄▅▆▇█
space=' '
saver=500
cava -p /home/psyamen/.config/cava/confs/waybarConf1 | while read -r line
  do
  saver=$((saver+1))
  if [ $saver -lt 500 ] ;
  then
    echo "%  "${bars:${line:0:1}:1}${bars:${line:2:1}:1}${bars:${line:4:1}:1}${bars:$(((${line:6:1}+${line:8:1})/2)):1}${bars:${line:10:1}:1}${bars:${line:12:1}:1}${bars:${line:14:1}:1}
  else
    echo "%"
  fi
  
  if [ "$line" != "0;0;0;0;0;0;0;0;" ];
  then
    saver=0
  fi
done
