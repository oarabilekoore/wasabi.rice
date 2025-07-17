#!/usr/bin/env bash

# List of options with emoji or icons
options=(
  "  Shutdown"
  "  Reboot"
  "  Suspend"
  "  Lock"
  "  Logout"
)

# Turn array into newline-separated string
choice=$(printf "%s\n" "${options[@]}" | rofi -dmenu -theme ~/.config/rofi/themes/powermenu-grid.rasi  -theme-str 'window { width: 15%; height: 10%; }' -p "Power Menu")

case "$choice" in
  "  Shutdown") systemctl poweroff ;;
  "  Reboot") systemctl reboot ;;
  "  Suspend") systemctl suspend ;;
  "  Lock") hyprlock --immediate ;;
  "  Logout") hyprctl dispatch exit ;;
esac
