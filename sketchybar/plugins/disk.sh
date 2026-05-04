#!/usr/bin/env bash
# APFS container usage (matches Stats.app).
USAGE=$(diskutil apfs list 2>/dev/null | grep "Capacity In Use" | grep -oE '[0-9.]+% used' | head -1)
sketchybar --set "$NAME" label="${USAGE:-?}"
