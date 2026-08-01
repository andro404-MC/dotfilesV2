#!/bin/bash

echo "Sleep inhibition is active."
echo "Press Ctrl+C to stop."

systemd-inhibit --what=sleep --why="Manual sleep inhibitor" bash -c '
    while true; do
        sleep 60
    done
'
