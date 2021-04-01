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

#-----------------------------------------------------------------------------
# session
#-----------------------------------------------------------------------------

# raise soft limits to hard limits
ulimit $(
  diff <(ulimit -Ha) <(ulimit -Sa) |
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
