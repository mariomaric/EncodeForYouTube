#!/bin/bash
# Requirements: sed, tr, convert, ffmpeg
# Usage: mp32flv input.mp3

# Output file - change file extension from .mp3 to .flv
out=$(echo "$1" | sed 's/mp3/flv/')

# Creating black background w/ white text i.e. filename
bgr=/tmp/background.jpg
filename=$(echo "$1" | tr -d '.mp3' | tr '[:punct:]' ' ')
convert \
  -size 320x240 \
  xc:black -fill white \
  -gravity center -draw "text 0,0 '$filename'" \
  "$bgr"

# ffmpeg convert command
ffmpeg -loop_input -r 1 -i "$bgr" -i "$1" -acodec copy -shortest -qscale 11 -s 320x240 "$out"

# Delete background file
rm "$bgr"

exit
