#!/usr/bin/env bash
# i3status: volume master — format = "♪: %volume"
VOL=$(osascript -e 'output volume of (get volume settings)')
MUTED=$(osascript -e 'output muted of (get volume settings)')
if [ "$MUTED" = "true" ]; then
  sketchybar --set "$NAME" label="muted"
else
  sketchybar --set "$NAME" label="${VOL}%"
fi
