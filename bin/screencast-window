#!/bin/sh
#
# Usage: screencast-window [ARGUMENTS_FOR_BYZANZ_RECORD...]
#
# Take a video capture, in GIF format, of a single window.
#
# Written in 2010 by Suraj N. Kurapati <https://github.com/sunaku>

echo 'Select the window you want to video capture...'
byzanz-record $(xwininfo | awk '
  /Absolute upper-left X/ { x = $4 }
  /Absolute upper-left Y/ { y = $4 }
  /Width/                 { w = $2 }
  /Height/                { h = $2 }
  END                     { print "-x", x, "-y", y, "-w", w, "-h", h }
') -v "$@"
