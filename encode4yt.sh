#!/bin/bash
# Requirements: sed, imagemagick, ffmpeg
# Usage: encode4yt input

# 1) Prepare output file:
# 1.1) Find out extension of input file
ext="${1##*.}"

# 1.2) Set up extension of output file to mp4
out=$(echo "$1" | sed "s/$ext/mp4/")

# 2) Prepare background image:
# 2.1) Create variable with PNG image location
bgr=/tmp/background.png

# 2.2) Remove extension and punctuation marks from filename
filename=$(echo "$1" | sed "s/$ext//" | sed 's/[[:punct:]]/ /g')

# 2.3) Create background image from filename as white text on black background
convert \
  -size 426x240 \
  xc:black -fill white \
  -gravity center -draw "text 0,0 '$filename'" \
  "$bgr"

# 3) ffmpeg encode command
ffmpeg \
  -f image2 -loop 1 -framerate 1 -i "$bgr" -i "$1" \
  -c:v libx264 -preset medium -tune stillimage -crf 18 \
  -c:a copy -shortest \
  -pix_fmt yuv420p -s 426x240 "$out"

# 4) Delete background file
rm "$bgr"

exit
