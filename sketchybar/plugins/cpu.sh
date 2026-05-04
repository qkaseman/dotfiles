#!/usr/bin/env bash
PERCENT=$(ps -A -o %cpu | awk '{s+=$1} END {printf "%.0f%%", s}')
sketchybar --set "$NAME" label="$PERCENT"
