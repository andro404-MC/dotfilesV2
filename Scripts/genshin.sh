#! /usr/bin/env bash
get_notes() {
  curl --silent --request GET \
    --url "https://bbs-api-os.hoyoverse.com/game_record/genshin/api/dailyNote?server=os_euro&role_id=$GENSHIN_UID" \
    --cookie "ltoken_v2=$HOYO_TOKEN; ltuid_v2=$HOYO_LTUID;"
}

resin() {
  NOTES=$(get_notes)

  if [[ -z "$NOTES" || "$NOTES" == "null" ]]; then
    echo "Error: Unable to retrieve data" >&2
    return 1
  fi

  CURRENT_RESIN=$(echo "$NOTES" | jq -r '.data.current_resin // "?"')
  MAX_RESIN=$(echo "$NOTES" | jq -r '.data.max_resin // "?"')
  TIME_LEFT=$(bttf span round -l hour "$(echo "$NOTES" | jq -r '.data.resin_recovery_time // "N/A"')s")

  # Properly format JSON output with variable expansion
  jq --unbuffered --compact-output --null-input \
    --arg text "$CURRENT_RESIN/$MAX_RESIN" \
    --arg tooltip "$TIME_LEFT Left" \
    '{"text": $text, "tooltip": $tooltip}'
}

case "$1" in
resin)
  resin
  ;;
*)
  echo "Usage: $0 resin"
  ;;
esac
