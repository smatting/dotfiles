#!/usr/bin/env bash

stalonetray &
xmobar ~/.xmobarrc & 
compton &
volti &
setxkbmap -option compose:menu &
feh --bg-scale ~/.wallpapers/highway_by_axiomdesign-d9em9fs.jpg
dropbox start

exec /usr/local/bin/xmonad
