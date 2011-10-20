# bind special keys according to readline configuration
eval "$(sed -n 's/^/bindkey /; s/: / /p' /etc/inputrc)"

# do not erase entire line when Control-U is pressed
bindkey '^U' backward-kill-line

# make ^W stop at non-alphanumeric characters
autoload -U select-word-style
select-word-style bash

# keep command history unique to fit more items in it!
setopt histignorealldups
