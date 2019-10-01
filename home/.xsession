#!/bin/sh -l

dunst &
taffybar &
sct --nightTemp 5000 &
libinput-gestures &
nm-applet --sm-disable &
dropbox &
blueman-applet &
eval `ssh-agent` 
feh --bg-scale ~/.wallpapers/highway_by_axiomdesign-d9em9fs.jpg &
export _JAVA_AWT_WM_NONREPARENTING=1
exec xmonad
