#!/usr/bin/env bash
# Called by SketchyBar on aerospace_workspace_change event.
# $NAME is the item name (e.g., "space.3").
# $FOCUSED_WORKSPACE is set by the AeroSpace trigger.
SID="${NAME#space.}"
if [ "$SID" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set "$NAME" background.drawing=on
else
  sketchybar --set "$NAME" background.drawing=off
fi
