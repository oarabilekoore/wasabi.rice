#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
HYPAPER_CONF="$HOME/.config/hypr/hyprpaper.conf"

# Let user pick an image from the folder using Rofi
SELECTED=$(find "$WALLPAPER_DIR" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" \) \
  | sort \
  | rofi -dmenu -p "Choose Wallpaper" -theme)

# If user made a selection
if [ -n "$SELECTED" ]; then
  # (Optional) Use pywal for color theming - comment out if you don’t use it
  # wal -i "$SELECTED" -b colorthief

  # Kill any running hyprpaper instance
  pkill hyprpaper
  sleep 0.5

  # Start hyprpaper in the background
  hyprpaper & disown
  sleep 0.5

  # Get primary monitor name (adjust if needed)
  MONITOR=$(hyprctl monitors -j | jq -r '.[0].name')

  # Preload the selected wallpaper
  hyprctl hyprpaper preload "$SELECTED"
  sleep 0.2

  # Set wallpaper
  hyprctl hyprpaper wallpaper "$MONITOR,$SELECTED"

  # 🔒 Save as persistent config
  mkdir -p "$(dirname "$HYPAPER_CONF")"
  echo "preload = $SELECTED" > "$HYPAPER_CONF"
  echo "wallpaper = $MONITOR,$SELECTED" >> "$HYPAPER_CONF"
fi
