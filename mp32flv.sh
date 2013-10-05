#!/bin/bash
# Requirements: sed, imagemagick, ffmpeg
# Usage: mp32flv input.mp3

# Prepare output file i.e. change file extension from .mp3 to .flv
out=$(echo "$1" | sed 's/mp3/flv/')

# Prepare background variable / JPEG image
bgr=/tmp/background.jpg

# Remove extension and punctuation marks from filename
filename=$(echo "$1" | sed 's/\.mp3//' | sed 's/[[:punct:]]/ /g')

# Create background image from filename as white text on black background
convert \
  -size 426x240 \
  xc:black -fill white \
  -gravity center -draw "text 0,0 '$filename'" \
  "$bgr"

# ffmpeg convert command
ffmpeg -f image2 -loop 1 -framerate 1 -i "$bgr" -i "$1" -codec:a copy -shortest -q:v 11 -s 426x240 "$out"

# Delete background file
rm "$bgr"

exit
