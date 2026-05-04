#!/usr/bin/env bash
PERCENT=$(pmset -g batt | grep -oE '[0-9]+%' | head -1)
sketchybar --set "$NAME" label="${PERCENT:-?}"
