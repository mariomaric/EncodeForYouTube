## Why?

Because I want to **upload audio files to YouTube**.

To be able to do that I must first [convert audio files into a format that will work on YouTube](https://support.google.com/youtube/answer/1696878?hl=en&ref_topic=2888648 "Upload audio or image files @ YouTube upload instructions and settings help") and I want to do that through GNU/Linux command-line.

## What?

This bash shell wrapper script will take **audio file as input** and **output video file** ready for upload to YouTube (e.g., via command-line script [youtube-upload](https://code.google.com/p/youtube-upload/ "youtube-upload")).

Audio formats supported: MP2, MP3, LC-AAC, HE-AAC, AC3

Output file will be slightly bigger than input file because quality of audio file remains unchanged.

## How?

Usage: `encode4yt input`

Output file will be written in same directory where input file is located and also will have identical name, only different extension (i.e., **.mp4**).

## Requirements

1. [GNU sed](http://www.gnu.org/software/sed/ "GNU sed")
2. [ImageMagick](http://www.imagemagick.org/ "ImageMagick")
3. [FFmpeg](http://ffmpeg.org/ "FFmpeg")

## Misc

This script is based on various sources from Internet, mostly from:

- [EncodeforYouTube FFmpeg wiki page](https://trac.ffmpeg.org/wiki/EncodeforYouTube "How to Encode Videos for YouTube and other Video Sharing Sites")
- [FFmpeg documentation](http://ffmpeg.org/ffmpeg-all.html "FFmpeg documentation")
- [ImageMagick v6 Examples -- Text to Image Handling](http://www.imagemagick.org/Usage/text/ "ImageMagick v6 Examples -- Text to Image Handling")
- [Advanced encoding settings](https://support.google.com/youtube/answer/1722171?hl=en&ref_topic=2888648 "Advanced encoding settings @ YouTube upload instructions and settings help")
