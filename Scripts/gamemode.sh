#! /usr/bin/env bash
state=$(gamemoded -s | awk '{print $3}')
if [[ $state == active  ]]; then
  echo ""
fi

if [[ $state == inactive ]]; then
  echo ""
fi
