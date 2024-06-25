#! /usr/bin/env bash
menu="mount\nunmount\npoweroff"
notificationIco="$HOME/.local/share/icons/Papirus-Dark/16x16/panel/drive-removable-media-usb-panel.svg"

selected=$(echo -e $menu | dmenu \
  -p "Select Option" \
  -h 26 -nb \#1a1b26 -nf \#C5C8C6 -sb \#7aa2f7 -sf \#1a1b26 \
  -fn 'scientifica')

mountfnc() {
  driveList=$(lsblk -rpo NAME,LABEL,MOUNTPOINT --noheadings \
    | cut -d' ' -f1,2,3 --output-delimiter=", " \
    | awk '$1 != "" && $2 !="," && $2 !="" && $3 == ""' \
    | sed 's/,//g')

  if [[ $driveList == "" ]]; then
    notify-send "no drive to mount" -i "$notificationIco"
    exit
  fi

  selectedD=$(echo -e $driveList | dmenu \
    -p "Select Drive" -h 26 -nb \#1a1b26 -nf \#C5C8C6 -sb \#7aa2f7 -sf \#1a1b26 \
    -fn 'scientifica' \
    | awk '{print $1}' )

  if [[ $selectedD == "" ]]; then
    exit
  fi
  out=$(udisksctl mount --block-device $selectedD)
  notify-send "$out" -i "$notificationIco"
}

unmountfnc() {
  driveList=$(lsblk -rpo NAME,LABEL,MOUNTPOINT --noheadings \
    | cut -d' ' -f1,2,3 --output-delimiter=", " \
    | awk '$1 != "" && $2 !="," && $2 !="" && $3 != ""' \
    | sed 's/,//g' | awk '{print $1, $2}')

  if [[ $driveList == "" ]]; then
    notify-send "no drive to umount" -i "$notificationIco"
    exit
  fi


  selectedD=$(echo $driveList | dmenu \
    -p "Select Drive" -h 26 -nb \#1a1b26 -nf \#C5C8C6 -sb \#7aa2f7 -sf \#1a1b26 \
    -fn 'scientifica' \
    | awk '{print $1}' )

  if [[ $selectedD == "" ]]; then
    exit
  fi

  out=$(udisksctl unmount --block-device $selectedD)
  notify-send "$out" -i "$notificationIco"
}

powerofffnc() {
  driveList=$(lsblk -rpo NAME,LABEL,MOUNTPOINT --noheadings \
    | cut -d' ' -f1,2,3 --output-delimiter=", " \
    | awk '$1 != "" && $2 !="," && $2 !=""' \
    | sed 's/,//g' | awk '{print $1, $2}')

  if [[ $driveList == "" ]]; then
    notify-send "no drive to poweroff" -i "$notificationIco"
    exit
  fi


  selectedD=$(echo $driveList | dmenu \
    -p "Select Drive" -h 26 -nb \#1a1b26 -nf \#C5C8C6 -sb \#7aa2f7 -sf \#1a1b26 \
    -fn 'scientifica')
  drivename=$(echo $selectedD | awk '{print $2}')
  drivePath=$(echo $selectedD | awk '{print $1}')

  if [[ $selectedD == "" ]]; then
    exit
  fi

  udisksctl unmount --block-device $drivePath
  udisksctl power-off --block-device $drivePath
  notify-send "$drivename has been powered off" -i "$notificationIco"
}

case $selected in
  mount) mountfnc ;;
  unmount) unmountfnc ;;
  poweroff) powerofffnc ;;
  *) echo "got" $selected ;;
esac
