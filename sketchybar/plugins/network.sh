#!/usr/bin/env bash
# Network throughput on active interface.
IFACE=$(route -n get default 2>/dev/null | awk '/interface:/ {print $2}')
if [ -z "$IFACE" ]; then
  sketchybar --set "$NAME" label="down"
  exit 0
fi

IBYTES1=$(netstat -I "$IFACE" -b | awk 'NR==2 {print $7}')
OBYTES1=$(netstat -I "$IFACE" -b | awk 'NR==2 {print $10}')
sleep 1
IBYTES2=$(netstat -I "$IFACE" -b | awk 'NR==2 {print $7}')
OBYTES2=$(netstat -I "$IFACE" -b | awk 'NR==2 {print $10}')

DOWN=$(( (IBYTES2 - IBYTES1) / 1024 ))
UP=$(( (OBYTES2 - OBYTES1) / 1024 ))

sketchybar --set "$NAME" label="↓${DOWN}K ↑${UP}K"
