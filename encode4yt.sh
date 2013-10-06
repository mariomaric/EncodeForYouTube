#!/bin/bash
# Requirements: sed, imagemagick, ffmpeg
# Usage: encode4yt input

# 1) Prepare output file:
# 1.1) Find out extension of input audio file
ext="${1##*.}"

# 1.2) Set up extension of output file to mp4
out=$(echo "$1" | sed "s/$ext/mp4/")

# 2) Prepare background image:
# 2.1) Create variable with PNG image location
bgr=/tmp/background.png

# 2.2) Remove extension and punctuation marks from filename
filename=$(echo "$1" | sed "s/$ext//" | sed 's/[[:punct:]]/ /g')

# 2.3) Create background image using filename as white text on black background
convert \
  -size 426x240 \
  -background black -fill white \
  -gravity center caption:"$filename" \
  "$bgr"

# 3) Create video with background image and input audio file
ffmpeg \
  -f image2 -loop 1 -framerate 1 -i "$bgr" -i "$1" \
  -c:v libx264 -preset medium -tune stillimage -crf 18 \
  -c:a copy -shortest \
  -pix_fmt yuv420p -s 426x240 "$out"

# 4) Delete background image
rm "$bgr"

exit
