#!/usr/bin/env bash

AUTH_DIR="$HOME/.config/rdp-auth/"

selected=$(find "$AUTH_DIR" -maxdepth 1 -type f -printf '%f\n' | sort |
  bemenu -H 26 --cw 2 --ch 14 --hp 10 -i \
    -p "RDP Profile" --fn 'scientifica' \
    --tb="#7aa2f7" --tf="#1a1b26" \
    --fb="#1a1b26" \
    --nb="#1a1b26" --nf="#C5C8C6" \
    --ab="#1a1b26" --af="#C5C8C6" \
    --hb="#7aa2f7" --hf="#1a1b26")

[[ -z "$selected" ]] && exit 0

file="$AUTH_DIR/$selected"

get_value() {
  awk -F'=' -v key="$1" '
        $1 ~ "^[[:space:]]*" key "[[:space:]]*$" {
            sub(/^[[:space:]]+/, "", $2)
            sub(/[[:space:]]+$/, "", $2)
            print $2
            exit
        }
    ' "$file"
}

ip=$(get_value ip)
username=$(get_value username)
domain=$(get_value domain)
password=$(get_value password)
drive=$(get_value drive-mount)

cmd=(
  wlfreerdp3
  /f
  /dynamic-resolution
  /clipboard
  /compression
  /auto-reconnect
  /cert:ignore

  -themes
)

[[ -n "$ip" ]] && cmd+=("/v:$ip")
[[ -n "$username" ]] && cmd+=("/u:$username")
[[ -n "$domain" ]] && cmd+=("/d:$domain")
[[ -n "$password" ]] && cmd+=("/p:$password")
[[ -n "$drive" ]] && cmd+=("/drive:Home,$drive")

exec "${cmd[@]}"
