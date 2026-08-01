#! /usr/bin/env bash

set -euo pipefail

ICON="$HOME/.local/share/icons/Papirus-Dark/16x16/panel/drive-removable-media-usb-panel.svg"
DRIVES=""

menu() {
  local prompt="$1"
  bemenu -H 26 --cw 2 --ch 14 --hp 10 -i \
    -p "$prompt" --fn 'scientifica' \
    --tb="#7aa2f7" --tf="#1a1b26" \
    --fb="#1a1b26" \
    --nb="#1a1b26" --nf="#C5C8C6" \
    --ab="#1a1b26" --af="#C5C8C6" \
    --hb="#7aa2f7" --hf="#1a1b26"
}

die() {
  notify-send -u critical -i "$ICON" "Drive tool" "$1"
  exit 1
}

load_drives() {
  DRIVES=$(lsblk -Jo NAME,LABEL,MOUNTPOINT,SIZE,TYPE,PKNAME 2>/dev/null |
    jq -c '[.blockdevices[] | .. | objects
      | select(.type == "part"
        or (.type == "disk" and ((.children // []) | length) == 0))]') ||
    die "Could not list block devices"
}

list_for() {
  local mode="$1"
  case "$mode" in
    mount) jq -c '[.[] | select(.mountpoint == null)]' <<<"$DRIVES" ;;
    unmount) jq -c '[.[] | select(.mountpoint != null)]' <<<"$DRIVES" ;;
    *) jq -c '.' <<<"$DRIVES" ;;
  esac
}

format_lines() {
  local mode="$1"
  case "$mode" in
    unmount) jq -r '.[] | [.name, (.label // "?"), .mountpoint] | join("  ")' ;;
    *) jq -r '.[] | [.name, (.label // "?"), .size] | join("  ")' ;;
  esac
}

pick_drive() {
  local prompt="$1" mode="$2" choice

  if ! jq -e 'length > 0' >/dev/null <<<"$(list_for "$mode")"; then
    notify-send -i "$ICON" "$prompt" "No matching drive found"
    return 1
  fi

  choice=$(format_lines "$mode" <<<"$(list_for "$mode")" | menu "$prompt") || true
  [[ -z "$choice" ]] && return 1
  awk '{print $1}' <<<"$choice"
}

udisks_do() {
  local verb="$1" device="$2" msg
  if msg=$(udisksctl "$verb" --block-device "$device" 2>&1); then
    notify-send -i "$ICON" "${verb^}ed" "$msg"
  else
    notify-send -u critical -i "$ICON" "${verb^} failed" "$msg"
  fi
}

mount_selected() {
  local device
  if device=$(pick_drive "Select Drive to Mount" "mount"); then
    udisks_do mount "$device"
  fi
}

unmount_selected() {
  local device
  if device=$(pick_drive "Select Drive to Unmount" "unmount"); then
    udisks_do unmount "$device"
  fi
}

poweroff_selected() {
  local device target msg

  if ! device=$(pick_drive "Select Drive to Power Off" "poweroff"); then
    return 0
  fi

  target=$(jq -r --arg d "$device" \
    '.[] | select(.name == $d) | (.pkname // "")' <<<"$DRIVES")
  [[ -n "$target" ]] && device="/dev/$target"

  udisksctl unmount --block-device "$device" 2>/dev/null || true

  if msg=$(udisksctl power-off --block-device "$device" 2>&1); then
    notify-send -i "$ICON" "Powered off" "$device"
  else
    notify-send -u critical -i "$ICON" "Power-off failed" "$msg"
  fi
}

main() {
  load_drives

  local action
  action=$(printf '%s\n' mount unmount poweroff | menu "Select Option") || true
  [[ -z "$action" ]] && return 0

  case "$action" in
    mount) mount_selected ;;
    unmount) unmount_selected ;;
    poweroff) poweroff_selected ;;
    *) echo "unknown action: $action" >&2 && return 1 ;;
  esac
}

main "$@"
