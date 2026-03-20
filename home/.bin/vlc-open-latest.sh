#!/usr/bin/env bash

set -e
cd ~/Downloads
file=$(ls -1t . | head -n 1)
vlc "$file"
