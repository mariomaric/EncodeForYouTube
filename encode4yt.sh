#!/bin/bash
# Info: https://github.com/mariomaric/EncodeForYouTube#readme



### Initial steps

# Initiate input variable
input="$1"

# Find out extension of input audio file using Shell Parameter Expansion
ext="${input##*.}"

# Various checkups
case "$ext" in
    mp2|mp3 )
        # If MP2 or MP3 audio file sampling rate is not 44.1 kHz re-encode it for output
        if [[ "$(ffprobe -print_format flat -show_entries stream=codec_time_base -loglevel fatal "$input")" != *44100* ]]
        then
            acodec="libmp3lame -ar 44100"
        else
            acodec="copy"
        fi
        ;;
    m4a|m4b|m4p|m4r|3gp|aac|ac3 )
        acodec="copy"
        ;;
    * )
        echo "Unsuported audio format."
        echo "Info: https://github.com/mariomaric/EncodeForYouTube#readme"
        exit 1
        ;;
esac

# Set up size for background image and video
size="1920x1080"



### Prepare output file:

# Set up extension of output file to mp4
output="$(echo "$input" | sed "s/$ext/mp4/")"



### Prepare background image:

# Check if second argument is provided
if [ -z "$2" ]
then
    # Create variable with PNG image location
    bgr="/tmp/background.png"

    # Remove extension and punctuation marks from filename
    filename="$(echo "$input" | sed "s/$ext//" | sed 's/[[:punct:]]/ /g')"

    # Create background image using filename as white text on black background
    convert \
        -size "$size" \
        -background black -fill white \
        -depth 8 -type Grayscale \
        -gravity center label:"$filename" \
        "$bgr"
else
    # Use second argument as a background image
    if [ -f "$2" ]
    then
        bgr="$2"
    else
        echo "$2 not found."
        exit 1
    fi
fi



### Create video with background image and input audio file
ffmpeg \
    -f image2 -loop 1 -framerate 1 -i "$bgr" -i "$input" \
    -codec:v libx264 -preset medium -tune stillimage -crf 18 \
    -codec:a $acodec -shortest \
    -pix_fmt yuv420p -s "$size" "$output" -loglevel error



### Delete background image
if [ -z "$2" ]
then
    rm "$bgr"
fi

exit 0
