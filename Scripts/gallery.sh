#! /usr/bin/env bash
folder=~/Pictures/$(ls ~/Pictures/ -1 \
  | dmenu -p "Select Folder" \
  -h 26 -nb \#1a1b26 -nf \#C5C8C6 -sb \#7aa2f7 -sf \#1a1b26 \
  -fn 'scientifica')
nsxiv -b -f -t $folder
