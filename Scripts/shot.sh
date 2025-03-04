#! /usr/bin/env bash

time=`date +%Y-%m-%d-%H-%M-%S`
dir=`xdg-user-dir SCREENSHOTS`
file="Screenshot_${time}.png"

/usr/share/sway-contrib/grimshot savecopy screen --notify $dir/$file
