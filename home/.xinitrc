#!/usr/bin/env bash

stalonetray &
xmobar ~/.xmobarrc & 
compton &
feh --bg-scale ~/.wallpapers/highway_by_axiomdesign-d9em9fs.jpg

exec /usr/local/bin/xmonad
