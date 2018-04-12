#!/bin/sh -l

dunst &
taffybar &
sct --nightTemp 5000 &
libinput-gestures &
nm-applet --sm-disable &
feh --bg-scale ~/.wallpapers/highway_by_axiomdesign-d9em9fs.jpg &
exec xmonad
