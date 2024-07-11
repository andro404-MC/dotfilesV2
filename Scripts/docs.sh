#! /usr/bin/env bash
clear
langs=`echo "golang javascript css" | tr ' ' '\n'`
selected=`printf "$langs" | fzf`
read -p "query : " query

curl -s https://cht.sh/$selected/`echo $query | tr ' ' '+'` | less -r
