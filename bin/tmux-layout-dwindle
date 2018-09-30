#!/bin/sh -eu
#
# Usage: tmux-layout-dwindle [tblrhvsc]...
#
# Arranges panes in the current window into Binary Space Partitions of
# dwindling size towards a corner of the screen (tl, tr, bl, br) along
# a straight line (c) or spiral trajectory (s) while laying out branch
# panes either vertically (v) or horizontally (h) to produce one of 16
# possible orientations, illustrated below, of which "brvc" is default.
#
# Inspired by the dwindle and spiral layout concepts by Niki Yoshiuchi
# in dwm's fibonacci patch <http://dwm.suckless.org/patches/fibonacci>.
#
#
#
#
#                        oooo    ooo  .ooooo.
#                         `88.  .8'  d88' `"Y8
#                          `88..8'   888
#                           `888'    888   .o8
#                            `8'     `Y8bod8P'
#
#
#
#                           vertical corner
#
#
#
#         tlvc                                           trvc
#
#         +--+--+-----+-----------+ +-----------+-----+--+--+
#         |\\|5 |     |           | |           |     | 5|//|
#         +--+--+  3  |           | |           |  3  +--+--+
#         |  4  |     |           | |           |     |  4  |
#         +-----+-----+     1     | |     1     +-----+-----+
#         |           |           | |           |           |
#         |     2     |           | |           |     2     |
#         |           |           | |           |           |
#         +-----------+-----------+ +-----------+-----------+
#
#         +-----------+-----------+ +-----------+-----------+
#         |           |           | |           |           |
#         |     2     |           | |           |     2     |
#         |           |           | |           |           |
#         +-----+-----+     1     | |     1     +-----+-----+
#         |  4  |     |           | |           |     |  4  |
#         +--+--+  3  |           | |           |  3  +--+--+
#         |//|5 |     |           | |           |     | 5|\\|
#         +--+--+-----+-----------+ +-----------+-----+--+--+
#
#         blvc                                           brvc
#
#
#
#
#
#                        oooo    ooo  .oooo.o
#                         `88.  .8'  d88(  "8
#                          `88..8'   `"Y88b.
#                           `888'    o.  )88b
#                            `8'     8""888P'
#
#
#
#                           vertical spiral
#
#
#
#         tlvs                                           trvs
#
#         +-----+-----+-----------+ +-----------+-----+-----+
#         |     |  4  |           | |           |  4  |     |
#         |  3  +--+--+           | |           +--+--+  3  |
#         |     |\\|5 |           | |           | 5|//|     |
#         +-----+--+--+     1     | |     1     +--+--+-----+
#         |           |           | |           |           |
#         |     2     |           | |           |     2     |
#         |           |           | |           |           |
#         +-----------+-----------+ +-----------+-----------+
#
#         +-----------+-----------+ +-----------+-----------+
#         |           |           | |           |           |
#         |     2     |           | |           |     2     |
#         |           |           | |           |           |
#         +-----+--+--+     1     | |     1     +--+--+-----+
#         |     |//|5 |           | |           | 5|\\|     |
#         |  3  +--+--+           | |           +--+--+  3  |
#         |     |  4  |           | |           |  4  |     |
#         +-----+-----+-----------+ +-----------+-----+-----+
#
#         blvs                                           brvs
#
#
#
#                        oooo
#                        `888
#                         888 .oo.    .ooooo.
#                         888P"Y88b  d88' `"Y8
#                         888   888  888
#                         888   888  888   .o8
#                        o888o o888o `Y8bod8P'
#
#
#
#                          horizontal corner
#
#
#
#         tlhc                                           trhc
#
#         +-----+-----+-----------+ +-----------+-----+-----+
#         | \\\ |     |           | |           |     | /// |
#         +-----+  4  |           | |           |  4  +-----+
#         |  5  |     |           | |           |     |  5  |
#         +-----+-----+     2     | |     2     +-----+-----+
#         |           |           | |           |           |
#         |     3     |           | |           |     3     |
#         |           |           | |           |           |
#         +-----------+-----------+ +-----------+-----------+
#         |                       | |                       |
#         |                       | |                       |
#         |                       | |                       |
#         |           1           | |           1           |
#         |                       | |                       |
#         |                       | |                       |
#         |                       | |                       |
#         +-----------------------+ +-----------------------+
#
#         +-----------------------+ +-----------------------+
#         |                       | |                       |
#         |                       | |                       |
#         |                       | |                       |
#         |           1           | |           1           |
#         |                       | |                       |
#         |                       | |                       |
#         |                       | |                       |
#         +-----------+-----------+ +-----------+-----------+
#         |           |           | |           |           |
#         |     3     |           | |           |     3     |
#         |           |           | |           |           |
#         +-----+-----+     2     | |     2     +-----+-----+
#         |  5  |     |           | |           |     |  5  |
#         +-----+  4  |           | |           |  4  +-----+
#         | /// |     |           | |           |     | \\\ |
#         +-----+-----+-----------+ +-----------+-----+-----+
#
#         blhc                                           brhc
#
#
#
#                        oooo
#                        `888
#                         888 .oo.    .oooo.o
#                         888P"Y88b  d88(  "8
#                         888   888  `"Y88b.
#                         888   888  o.  )88b
#                        o888o o888o 8""888P'
#
#
#
#                          horizontal spiral
#
#
#
#         tlhs                                           trhs
#
#         +-----------+-----------+ +-----------+-----------+
#         |           |           | |           |           |
#         |     3     |           | |           |     3     |
#         |           |           | |           |           |
#         +-----+-----+     2     | |     2     +-----+-----+
#         |     | \\\ |           | |           | /// |     |
#         |  4  +-----+           | |           +-----+  4  |
#         |     |  5  |           | |           |  5  |     |
#         +-----+-----+-----------+ +-----------+-----+-----+
#         |                       | |                       |
#         |                       | |                       |
#         |                       | |                       |
#         |           1           | |           1           |
#         |                       | |                       |
#         |                       | |                       |
#         |                       | |                       |
#         +-----------------------+ +-----------------------+
#
#         +-----------------------+ +-----------------------+
#         |                       | |                       |
#         |                       | |                       |
#         |                       | |                       |
#         |           1           | |           1           |
#         |                       | |                       |
#         |                       | |                       |
#         |                       | |                       |
#         +-----+-----+-----------+ +-----------+-----+-----+
#         |     |  5  |           | |           |  5  |     |
#         |  4  +-----+           | |           +-----+  4  |
#         |     | /// |           | |           | \\\ |     |
#         +-----+-----+     2     | |     2     +-----+-----+
#         |           |           | |           |           |
#         |     3     |           | |           |     3     |
#         |           |           | |           |           |
#         +-----------+-----------+ +-----------+-----------+
#
#         blhs                                           brhs
#
#
#
#
# Written in 2016 by Suraj N. Kurapati <https://github.com/sunaku>
# Documented at <https://sunaku.github.io/tmux-layout-dwindle.html>

# parse any orientation flags specified among the command-line arguments
case "$*" in
  (*t*)   corner_tb=+ spiral_tb=        ;; # top
  (*b*|*) corner_tb=  spiral_tb=+       ;; # bottom
esac
case "$*" in
  (*l*)   corner_lr=+ spiral_lr=        ;; # left
  (*r*|*) corner_lr=  spiral_lr=+       ;; # right
esac
case "$*" in
  (*h*)   modulo_hv=0 is_vertical=false ;; # horizontal
  (*v*|*) modulo_hv=1 is_vertical=true  ;; # vertical
esac
case "$*" in
  (*s*)   is_spiral=true                ;; # spiral
  (*c*|*) is_spiral=false               ;; # corner
esac

# gather information about the current state of the window and its panes
set -- $(tmux list-panes -F '#{pane_id}')
selected_pane=$(tmux display-message -p '#{pane_id}')
historic_pane=$(tmux last-pane 2>/dev/null \;\
                     display-message -p '#{pane_id}' \;\
                     last-pane) ||: # exit 1 - no last pane
window_height=$(tmux display-message -p '#{window_height}')

# execute all tmux commands in one shot to avoid flickering and slowness
exec tmux $({

  # flatten current layout, stacking all panes vertically like pancakes
  echo select-layout even-vertical

  # transform pane stack into binary space partitions of dwindling size
  count=1
  for pane_id; do
    if [ $count -eq $# ]; then
      break # skip last pane because .+1 wraps around to the first pane
    elif [ $(( count % 2 )) -eq $modulo_hv ]; then
      move_h=+
      if $is_spiral && [ $(( count % 5 )) -gt 2 ]
      then move_b=$spiral_lr
      else move_b=$corner_lr
      fi
    else
      move_h=
      if $is_spiral && [ $(( count % 5 )) -gt 2 ]
      then move_b=$spiral_tb
      else move_b=$corner_tb
      fi
    fi
    echo resize-pane -t $pane_id -y $window_height # make room for move
    echo select-pane -t $pane_id # for relative pane addressing in move
    echo move-pane -d -s .+1 -t . ${move_h:+-h} ${move_b:+-b} # move it
    count=$(( count + 1 ))
  done

  # divide available space evenly among panes (binary space partitions)
  branch_height=$window_height
  count=1
  for pane_id; do
    if [ $count -eq $# ] && ! $is_vertical; then
      break # skip last pane because it will already be sized correctly
    elif [ $(( count % 2 )) -eq 1 ]; then
      # every other pane is a branch in the binary space partition tree
      parent_height=$branch_height
      branch_height=$(( branch_height / 2 ))
      if $is_vertical
      then resize_y=$parent_height
      else resize_y=$branch_height
      fi
      echo resize-pane -t $pane_id -y $resize_y
    fi
    count=$(( count + 1 ))
  done

  # restore pane selection back to how it was before we did any of this
  test -n "$historic_pane" && echo select-pane -t $historic_pane
  echo select-pane -t $selected_pane

} | sed 's/$/ ;/')
