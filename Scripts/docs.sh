#! /usr/bin/env bash
clear
langs="golang
javascript
css"
selected=$(printf '%s\n' "$langs" | fzf)
[[ -z "$selected" ]] && exit 0
read -p "query : " query
[[ -z "$query" ]] && exit 0

curl -s "https://cht.sh/$selected/$(printf '%s' "$query" | tr ' ' '+')" | less -r
