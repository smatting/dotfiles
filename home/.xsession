#!/bin/sh

taffybar &
sct &
nm-applet --sm-disable &
feh --bg-scale ~/.wallpapers/highway_by_axiomdesign-d9em9fs.jpg &
exec xmonad
