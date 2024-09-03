#!/bin/bash

# Directory containing wallpapers
WALLPAPER_DIR="$HOME/wallpapers"
THEMES_DIR="$HOME/.config/rofi/themes"
SWWW_TRANSITION_STEP=--transition-step=10
SWWW_TRANSITION_FPS=--transition-fps=60
SWWW_TRANSITION_TYPE=--transition-type=center
SWWW_OPTIONS="$SWWW_TRANSITION_STEP $SWWW_TRANSITION_FPS $SWWW_TRANSITION_TYPE"

# Ensure the directories exist
if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "Wallpaper directory does not exist: $WALLPAPER_DIR"
    exit 1
fi

if [ ! -d "$THEMES_DIR" ]; then
    echo "Themes directory does not exist: $THEMES_DIR"
    exit 1
fi

# Find all image files in the wallpaper directory and store them in an array
mapfile -t WALLPAPERS < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \))

# Check if any images were found
if [ ${#WALLPAPERS[@]} -eq 0 ]; then
    echo "No images found in the directory."
    exit 1
fi

# Generate list with image previews
MENU_ENTRIES=""
for FILEPATH in "${WALLPAPERS[@]}"; do
    FILENAME=$(basename "$FILEPATH")
    MENU_ENTRIES+="$FILENAME\x00icon\x1f$FILEPATH\n"
done

# Use rofi to select a wallpaper with image preview
SELECTED_WALLPAPER=$(echo -e "$MENU_ENTRIES" | rofi -dmenu -theme "${THEMES_DIR}/wallselect.rasi" -p "Select Wallpaper" -markup-rows)

# Extract the filename from the selected entry
SELECTED_FILENAME=$(echo "$SELECTED_WALLPAPER" | cut -d' ' -f2-)
echo "Selected wallpaper: $SELECTED_FILENAME"

# If a wallpaper was selected, set it as the wallpaper using swww
if [ -n "$SELECTED_FILENAME" ]; then
    FULL_PATH="$WALLPAPER_DIR/$SELECTED_FILENAME"
    swww img "$FULL_PATH" $SWWW_OPTIONS && wallust run $FULL_PATH && swaync-client -rs && pywalfox update
else
    echo "No wallpaper selected."
fi
