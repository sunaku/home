#
# History
#
# http://zsh.sourceforge.net/Doc/Release/Options.html#History
#
setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

HISTFILE=~/.zsh_history
HISTSIZE=4294967296 # 2^32
SAVEHIST=$HISTSIZE
