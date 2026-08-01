#! /usr/bin/env bash

on_interrupt() {
  pactl unload-module "$VirtualSpeaker"
  pactl unload-module "$VirtualMic"
  exit 0
}

trap on_interrupt INT TERM

# Load the virtual audio modules
VirtualSpeaker=$(pactl load-module module-null-sink sink_name=virtual_speaker sink_properties=device.description=VirtualSpeaker)
VirtualMic=$(pactl load-module module-virtual-source source_name=virtual_mic source_properties=device.description=VirtualMic master=virtual_speaker.monitor)

while true; do
  read -p "Text to speak: " text
  espeak "$text" --stdout | paplay -d virtual_speaker
done
