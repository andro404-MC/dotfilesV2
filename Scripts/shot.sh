#! /usr/bin/env bash

time=`date +%Y-%m-%d-%H-%M-%S`
dir=`xdg-user-dir SCREENSHOTS`
file="Screenshot_${time}.png"

grimshot savecopy screen $dir/$file
notify-send -A "xdg-open $dir/$file=a" -t 3000 -i "$dir/$file" "Screenshot of screen" "$file" | sh
