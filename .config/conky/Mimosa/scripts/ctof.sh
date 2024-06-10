#!/bin/bash

# Variable
temp=$(cat /sys/class/thermal/thermal_zone0/temp)
cputemp=$(expr $temp / 1000)

# Main
Cel=$(expr $cputemp \* 9 / 5)
echo $Cel

exit
