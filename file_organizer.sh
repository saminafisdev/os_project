#!/bin/bash

# Colors for formatting
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m'  # No Color

# Ask the user for the directory to organize
echo -e "${PURPLE}==================================${NC}"
echo -e "${PURPLE}||        🗃️   File Organizer     ||${NC}"
echo -e "${PURPLE}==================================${NC}"
echo -n "Enter the directory to organize: "
read TARGET_DIR

# Ensure the provided path is a directory
if [ ! -d "$TARGET_DIR" ]; then
    echo -e "${RED}Invalid directory. Please provide a valid directory.${NC}"
    exit 1
fi

# Define directories for each file type
DIRECTORIES=("Documents" "Images" "Music" "Videos" "Archives" "Scripts" "Others")

# Create directories if they don't exist
for DIR in "${DIRECTORIES[@]}"; do
    [ -d "$TARGET_DIR/$DIR" ] || mkdir "$TARGET_DIR/$DIR"
done

# Move files to corresponding directories
for FILE in "$TARGET_DIR"/*; do
    if [[ -f "$FILE" ]]; then
        case "${FILE,,}" in
            *.doc*|*.txt|*.pdf) mv "$FILE" "$TARGET_DIR/Documents/" ;;
            *.jpg|*.jpeg|*.png|*.gif|*.bmp) mv "$FILE" "$TARGET_DIR/Images/" ;;
            *.mp3|*.wav|*.flac) mv "$FILE" "$TARGET_DIR/Music/" ;;
            *.mp4|*.avi|*.mkv) mv "$FILE" "$TARGET_DIR/Videos/" ;;
            *.zip|*.tar|*.gz|*.bz2) mv "$FILE" "$TARGET_DIR/Archives/" ;;
            *.sh|*.py|*.pl|*.rb|*.js) mv "$FILE" "$TARGET_DIR/Scripts/" ;;
            *) mv "$FILE" "$TARGET_DIR/Others/" ;;
        esac
    fi
done

echo -e "${GREEN}Files in $TARGET_DIR have been organized!${NC}"
