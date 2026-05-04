#!/usr/bin/env bash
# i3status: load — format = "L: %1min"
LOAD=$(sysctl -n vm.loadavg | awk '{print $2}')
sketchybar --set "$NAME" label="$LOAD"
