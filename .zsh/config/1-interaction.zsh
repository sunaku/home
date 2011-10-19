# bind special keys according to readline configuration
eval "$(sed -n 's/^/bindkey /; s/: / /p' /etc/inputrc)"

# do not erase entire line when Control-U is pressed
bindkey '^U' backward-kill-line

# keep command history unique to fit more items in it!
setopt histignorealldups
