#!/bin/bash
# Privacy indicator: mic / camera / screen-recording on sway.
# Mirrors waybar's privacy module: a PipeWire node only counts while its state is
# "running" (idle nodes - the always-present camera Video/Source, the virtual
# rnnoise loopback - are ignored). Emits {"text","tooltip"}: one blue icon per
# active indicator; tooltip lists which app is using it.
#
#   mic    -> running Stream/Input/Audio nodes from real apps (node.passive /
#             node.virtual filter out the rnnoise noise-cancel loopback)
#   camera -> a running Video/Source node, or any process holding /dev/video* open
#   screen -> running Stream/Input/Video nodes (waybar's screenshare signal: the
#             app consuming the stream) or Stream/Output/Video (xdpw producer)
DUMP=$(pw-dump 2>/dev/null)

app_names() {
  jq -r --arg cls "$1" '
    . as $all
    | [ $all[] | select(.type=="PipeWire:Interface:Client")
         | {(.id|tostring): (.info.props["application.process.binary"] //
                            .info.props["application.name"] //
                            .info.props["pipewire.access.portal.app_id"] // "")}]
      | add as $clients
    | [ $all[] | select(.type=="PipeWire:Interface:Node"
          and .info.state=="running"
          and .info.props["media.class"]==$cls
          and .info.props["node.passive"]!=true
          and .info.props["node.virtual"]!=true)
        | $clients[.info.props["client.id"]|tostring] // .info.props["node.name"] ]
    | unique | join(", ")
  ' <<< "$DUMP"
}

screen_names=$(jq -r '
    . as $all
    | [ $all[] | select(.type=="PipeWire:Interface:Client")
         | {(.id|tostring): (.info.props["application.process.binary"] //
                            .info.props["application.name"] //
                            .info.props["pipewire.access.portal.app_id"] // "")}]
      | add as $clients
    | [ $all[] | select(.type=="PipeWire:Interface:Node"
          and .info.state=="running"
          and (.info.props["media.class"]=="Stream/Input/Video" or
               .info.props["media.class"]=="Stream/Output/Video"))
        | $clients[.info.props["client.id"]|tostring] // .info.props["node.name"] ]
    | unique | join(", ")
  ' <<< "$DUMP")

mic_names=$(app_names "Stream/Input/Audio")

camnodes=$(jq -r '[.[] | select(.type=="PipeWire:Interface:Node"
      and .info.props["media.class"]=="Video/Source"
      and .info.state=="running")] | length' <<< "$DUMP")

camera=false
camera_names=""
if [ "$camnodes" -gt 0 ]; then camera=true; fi
if [ "$camera" = false ] && fuser /dev/video[0-9]* 2>/dev/null | grep -q .; then camera=true; fi
if [ "$camera" = true ]; then
  camera_names=$(fuser /dev/video[0-9]* 2>/dev/null | tr ' ' '\n' | grep '^[0-9]' | sort -u |
    while read -r pid; do ps -o comm= -p "$pid" 2>/dev/null; done | sort -u | paste -sd ', ' -)
  [ -z "$camera_names" ] && camera_names="Camera"
fi

text=""
tooltip=""
if [ -n "$mic_names" ]; then
  text+="<span color='#7aa2f7' rise='600' font='10'>󰍬  </span>"
  tooltip+="Microphone: $mic_names"
fi
if [ "$camera" = true ]; then
  text+="<span color='#7aa2f7' rise='600' font='10'>󰦌  </span>"
  [ -n "$tooltip" ] && tooltip+=$'\n'
  tooltip+="Camera: $camera_names"
fi
if [ -n "$screen_names" ]; then
  text+="<span color='#7aa2f7' rise='600' font='10'>󰹑  </span>"
  [ -n "$tooltip" ] && tooltip+=$'\n'
  tooltip+="Screen: $screen_names"
fi

jq -cn --arg text "$text" --arg tooltip "$tooltip" '{text:$text, tooltip:$tooltip}'
