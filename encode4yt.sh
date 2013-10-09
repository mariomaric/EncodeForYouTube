#!/bin/bash
# Info: http://mariomaric.net/EncodeForYouTube/

# 1) Prepare output file:
# 1.1) Find out extension of input audio file
ext="${1##*.}"

# 1.2) Set up extension of output file to mp4
out=$(echo "$1" | sed "s/$ext/mp4/")

# 1.3) Set up size for background image and video
size=1920x1080

# 2) Prepare background image:
# 2.1) Create variable with PNG image location
bgr=/tmp/background.png

# 2.2) Remove extension and punctuation marks from filename
filename=$(echo "$1" | sed "s/$ext//" | sed 's/[[:punct:]]/ /g')

# 2.3) Create background image using filename as white text on black background
convert \
  -size "$size" \
  -background black -fill white \
  -gravity center label:"$filename" \
  "$bgr"

# 3) Create video with background image and input audio file
ffmpeg \
  -f image2 -loop 1 -framerate 1 -i "$bgr" -i "$1" \
  -c:v libx264 -preset medium -tune stillimage -crf 18 \
  -c:a copy -shortest \
  -pix_fmt yuv420p -s "$size" "$out"

# 4) Delete background image
rm "$bgr"

exit
