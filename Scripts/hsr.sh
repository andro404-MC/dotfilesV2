#! /usr/bin/env bash

gen_ds() {
  salt="6s25p5ox5y14umn1p61aqyyvbvvl3lrt"
  t=$(date +%s)
  r=$(shuf -i 100000-200000 -n 1)
  check="salt=${salt}&t=${t}&r=${r}"
  c=$(echo -n "$check" | md5sum | awk '{print $1}')
  echo "${t},${r},${c}"
}

get_notes() {
  DS=$(gen_ds)
  curl --silent --request GET \
    --url "https://bbs-api-os.hoyoverse.com/game_record/hkrpg/api/note?server=prod_official_eur&role_id=$HSR_UID" \
    --header 'x-rpc-app_version: 1.5.0' \
    --header 'x-rpc-client_type: 5' \
    --header "ds: $DS" \
    --cookie "ltoken_v2=$HOYO_TOKEN; ltuid_v2=$HOYO_LTUID;"
}

power() {
  NOTES=$(get_notes)

  if [[ -z "$NOTES" || "$NOTES" == "null" ]]; then
    echo "Error: Unable to retrieve data" >&2
    return 1
  fi

  CURRENT_POWER=$(echo "$NOTES" | jq -r '.data.current_stamina // "?"')
  MAX_POWER=$(echo "$NOTES" | jq -r '.data.max_stamina // "?"')
  TIME_LEFT=$(bttf span round -l hour "$(echo "$NOTES" | jq -r '.data.stamina_recover_time // "N/A"')s")

  jq --unbuffered --compact-output --null-input \
    --arg text "$CURRENT_POWER/$MAX_POWER" \
    --arg tooltip "$TIME_LEFT Left" \
    '{"text": $text, "tooltip": $tooltip}'
}

case "$1" in
power)
  power
  ;;
ds)
  gen_ds
  ;;
*)
  echo "Usage: $0 power"
  ;;
esac
