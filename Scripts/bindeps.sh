#! /usr/bin/env bash

trap "exit" INT

binpath=$1
NO_FORMAT="\033[0m"
C_NAVY="\033[38;5;4m"

if [[ $binpath == "" ]]; then
  echo "ERROR : binary not provided"
  exit
fi


if ! [ -f "$binpath" ]; then
  echo "$0: $binpath: No such file or directory"
  exit
fi

libraries=($(readelf -d $binpath | grep NEEDED | sed -n 's/.*\[\(.*\)\].*/\1/p'))

for lib in "${libraries[@]}"; do
    echo -e "\n${C_NAVY}Choices for library: $lib ${NO_FORMAT}"
    pacman -Fq $lib
done
