#!/bin/sh

. ~/.pathrc
export LANG=en_US.utf8
export XDG_DESKTOP_DIR=$HOME
export XDG_DOWNLOAD_DIR=$HOME/get
export XAUTHORITY=$HOME/.Xauthority
test -s /etc/crouton/name && export CROUTON=$(cat /etc/crouton/name)

# use ChromeOS' existing X11 server when inside crouton
if test -z "$DISPLAY" -a -n "$CROUTON" ; then
  export XAUTHORITY=/var/host/Xauthority
  export DISPLAY=:0.0
fi

# use all processors for fast, parallel make(1) builds
export MAKEFLAGS="-j$(fgrep -c processor /proc/cpuinfo)"

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
