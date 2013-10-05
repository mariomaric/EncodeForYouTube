#!/bin/bash
# Requirements: sed, imagemagick, ffmpeg
# Usage: encode4yt input.mp3

# Prepare output file i.e. change file extension from .mp3 to .flv
out=$(echo "$1" | sed 's/mp3/mp4/')

# Prepare background variable / PNG image
bgr=/tmp/background.png

# Remove extension and punctuation marks from filename
filename=$(echo "$1" | sed 's/\.mp3//' | sed 's/[[:punct:]]/ /g')

# Create background image from filename as white text on black background
convert \
  -size 426x240 \
  xc:black -fill white \
  -gravity center -draw "text 0,0 '$filename'" \
  "$bgr"

# ffmpeg convert command
ffmpeg \
  -f image2 -loop 1 -framerate 1 -i "$bgr" -i "$1" \
  -c:v libx264 -preset medium -tune stillimage -crf 18 \
  -c:a copy -shortest \
  -pix_fmt yuv420p -s 426x240 "$out"

# Delete background file
rm "$bgr"

exit
