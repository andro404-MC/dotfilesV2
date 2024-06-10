#!/bin/bash

# This command will close all active conky
killall conky
sleep 2s
		
# Only the config listed below will be avtivated
# if you want to combine with another theme, write the command here
cp $HOME/.config/conky/Mimosa/scripts/rings-v1.2.1.lua /tmp
conky -c $HOME/.config/conky/Mimosa/Mimosa.conf &> /dev/null &

exit
