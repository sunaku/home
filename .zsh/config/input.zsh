#
# Input and Output
#
# http://zsh.sourceforge.net/Doc/Release/Options.html#Input_002fOutput
#
setopt ALIASES
setopt CORRECT # CORRECT_IGNORE=
setopt CORRECT_ALL # CORRECT_IGNORE_FILE=
setopt DVORAK
setopt NO_FLOW_CONTROL # this is for ZSH itself
#
# disable XON (^S) and XOFF (^Q) flow control keys
# http://blog.sanctum.geek.nz/terminal-annoyances/
#
stty -ixon # this is for apps launched from ZSH
setopt INTERACTIVE_COMMENTS
setopt SHORT_LOOPS
