#!/bin/bash

CHOICE=$(printf "power-saver\nbalanced" | rofi -dmenu -p "Battery Mode" -theme ~/.config/rofi/themes/battery-menu.rasi)

if [[ "$CHOICE" == "" ]]; then
    exit 0
fi

powerprofilesctl set "$CHOICE" && notify-send "$CHOICE mode activated"
