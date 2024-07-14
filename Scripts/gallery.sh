#! /usr/bin/env bash
folder=~/Pictures/$(ls ~/Pictures/ -1 \
  | bemenu -B 0 -H 26 --cw 2 --ch 14 --hp 10 -i \
    -p "Select Option" --fn 'scientifica' \
    --tb="#7aa2f7" --tf="#1a1b26" \
    --fb="#1a1b26" \
    --nb="#1a1b26" --nf="#C5C8C6" \
    --ab="#1a1b26" --af="#C5C8C6" \
    --hb="#7aa2f7" --hf="#1a1b26")
nsxiv -b -f -t $folder
