#
# Input and Output
#
# http://zsh.sourceforge.net/Doc/Release/Options.html#Input_002fOutput
#
setopt ALIASES
setopt CORRECT # CORRECT_IGNORE=
setopt CORRECT_ALL
CORRECT_IGNORE_FILE='.*' # ignore hidden files
setopt DVORAK
setopt NO_FLOW_CONTROL # this is for ZSH itself
#
# disable XON (^S) and XOFF (^Q) flow control keys
# http://blog.sanctum.geek.nz/terminal-annoyances/
#
stty -ixon # this is for apps launched from ZSH
setopt INTERACTIVE_COMMENTS
setopt SHORT_LOOPS
#
# delete WORDs without stopping at sub-delimiters
#
bindkey "^[^[[3~" delete-word       # <Alt-Delete> for WORD ahead of cursor
bindkey "^[^?" backward-delete-word # <Alt-Backspace> for WORD behind cursor
#
# enable the <Delete> key in st-256color
# http://git.suckless.org/st/tree/FAQ#n32
#
test "$TERM" = st-256color && tput smkx
