# search paths for locally installed apps
export PATH=$HOME/bin:$HOME/opt/bin:$HOME/opt/sbin:$PATH
export LD_LIBRARY_PATH=$HOME/opt/lib:$HOME/opt/lib64:$LD_LIBRARY_PATH
export MANPATH=$HOME/opt/share/man:$MANPATH
export INFOPATH=$HOME/opt/share/info:$INFOPATH

# search paths for programming libraries
export CPATH=$HOME/opt/include:$CPATH
export GOPATH=$HOME/opt/install/GOPATH
export GEM_HOME=$HOME/opt/install/GEM_HOME
export GEM_PATH=$GEM_HOME:$GEM_PATH
export NPM_CONFIG_PREFIX=$HOME/opt/install/NPM_CONFIG_PREFIX
export NODE_PATH=$NPM_CONFIG_PREFIX/lib/node_modules:$NODE_PATH
export PKG_CONFIG_PATH=$HOME/opt/lib/pkgconfig:$PKG_CONFIG_PATH

# use all processors for fast, parallel make(1) builds
export MAKEFLAGS=-j$(grep -c '^processor' /proc/cpuinfo)

# enable shell history remembrance in iex(1) and erl(1)
# https://hexdocs.pm/iex/IEx.html#module-shell-history
export ERL_AFLAGS='-kernel shell_history enabled'

# use GTK+3 theme for Java applications
# https://wiki.archlinux.org/title/Java
export JDK_JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Djdk.gtk.version=3'

#-----------------------------------------------------------------------------
# session
#-----------------------------------------------------------------------------

# raise soft limits to hard limits
ulimit $(
  bash --noprofile --norc -c 'diff <(ulimit -Ha) <(ulimit -Sa)' |
  sed -n 's/^<.*\(-\w\).*\s/\1 /p'
) >/dev/null

#-----------------------------------------------------------------------------
# crouton
#-----------------------------------------------------------------------------

export LANG=en_US.UTF-8
export XDG_DESKTOP_DIR=$HOME
export XAUTHORITY=$HOME/.Xauthority
test -s /etc/crouton/name && export CROUTON=$(cat /etc/crouton/name)

#-----------------------------------------------------------------------------
# desktop
#-----------------------------------------------------------------------------

if test -n "$DISPLAY" && xhost >/dev/null; then
  xset +fp ~/.fonts/tamzen-font/bdf && xset fp rehash
  unset QT_STYLE_OVERRIDE
  export QT_QPA_PLATFORMTHEME=qt5ct
  export GTK_THEME=Nordic:dark
fi

# start X when logging into the first Virtual Terminal
# https://wiki.archlinux.org/index.php/Start_X_at_Login
# see also /etc/X11/xinit/xserverrc for $XDG_VTNR trick
test -z "$DISPLAY" -a "$(tty)" = /dev/tty1 &&
exec env XDG_VTNR=1 startx > ~/.xsession-errors 2>&1

#-----------------------------------------------------------------------------
# console
#-----------------------------------------------------------------------------

# reattach last tmux session after logging in through Crouton or through SSH,
# in which case we must also not be SSH'ing into the same machine from itself
test -z "$TMUX" && {
  test -n "$CROUTON" ||
  echo "$SSH_CONNECTION" | awk '{ exit $1 == $3 }'
} && {
  tmux has-session 2>/dev/null && tmux -2 attach -d || {
    printf 'No tmux sessions found.  Start one? (y/N) '
    read answer && echo "$answer" | grep -q -i '^y' &&
    eval "${CROUTON:+env TERM=xterm-256color} tmux -2"
  }
}
