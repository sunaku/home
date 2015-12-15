#!/bin/sh

. ~/.pathrc
export LANG=en_US.utf8
export XDG_DESKTOP_DIR=$HOME
export XAUTHORITY=$HOME/.Xauthority
test -s /etc/crouton/name && export CROUTON=$(cat /etc/crouton/name)

# LaTeX binaries are not found in default /bin folders
texlive=/etc/profile.d/texlive.sh
test -f $texlive && . $texlive

# use ChromeOS' existing X11 server when inside crouton
if test -z "$DISPLAY" -a -n "$CROUTON" ; then
  export XAUTHORITY=/var/host/Xauthority
  export DISPLAY=:0.0
fi

# use all processors for fast, parallel make(1) builds
export MAKEFLAGS="-j$(fgrep -c processor /proc/cpuinfo)"

# start X when logging into the first Virtual Terminal
# https://wiki.archlinux.org/index.php/Start_X_at_Login
# see also /etc/X11/xinit/xserverrc for $XDG_VTNR trick
test -z "$DISPLAY" -a "$(tty)" = /dev/tty1 &&
exec env XDG_VTNR=1 startx > ~/.xsession-errors 2>&1

# reattach last tmux session after logging in through Crouton or through SSH,
# in which case we must also not be SSH'ing into the same machine from itself
test -z "$TMUX" && {
  test -n "$CROUTON" ||
  echo "$SSH_CONNECTION" | awk '{ exit $1 == $3 }'
} && {
  tmux has-session 2>/dev/null && tmux -2 attach -d || {
    echo -n 'No tmux sessions found.  Start one? (y/n) '
    read && echo "$REPLY" | grep -qi '^y' && tmux -2
  }
}
