#
# History
#
# http://zsh.sourceforge.net/Doc/Release/Options.html#History
#
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_SAVE_BY_COPY
setopt HIST_FCNTL_LOCK

setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS

setopt BANG_HIST
setopt HIST_VERIFY

HISTFILE=~/.zsh_history
HISTSIZE=2147483647 # value of 32-bit LONG_MAX from /usr/include/limits.h
SAVEHIST=$HISTSIZE  # see http://www.zsh.org/mla/users/2013/msg00691.html
