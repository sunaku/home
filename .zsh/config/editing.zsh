# bind special keys according to readline configuration
eval "$(sed -n 's/^/bindkey /; s/: / /p' /etc/inputrc)"

# do not erase entire line when Control-U is pressed
bindkey '^U' backward-kill-line

# make ^W stop at non-alphanumeric characters
autoload -U select-word-style
select-word-style bash

# edit the command line in your favorite editor
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line
