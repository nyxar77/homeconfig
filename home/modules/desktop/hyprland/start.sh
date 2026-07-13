#!/usr/bin/env bash

if command -v cliphist >/dev/null && command -v wl-paste >/dev/null; then
  pgrep -f "wl-paste --type text --watch cliphist store" >/dev/null ||
    wl-paste --type text --watch cliphist store &
  pgrep -f "wl-paste --type image --watch cliphist store" >/dev/null ||
    wl-paste --type image --watch cliphist store &
fi

# bash ~/.config/hypr/dynamic-border.sh &
