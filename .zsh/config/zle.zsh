#
# ZSH Line Editor
#
# http://zsh.sourceforge.net/Doc/Release/Options.html#Zle
#
setopt BEEP

# use EMACS-style keybindings for command line editing
bindkey -e

# bind special keys according to readline configuration
eval "$(sed -n 's/^\( *[^#][^:]*\):/bindkey \1/p' /etc/inputrc ~/.inputrc)"

# do not erase entire line when Control-U is pressed
bindkey '^U' backward-kill-line

# make ^W stop at non-alphanumeric characters
autoload -U select-word-style
select-word-style bash

# edit the command line in your favorite editor
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# automatically escape special characters in URLs
# http://blog.viridian-project.de/2008/07/03/zsh-tip-handling-urls-with-url-quote-magic/
autoload -U url-quote-magic
zle -N self-insert url-quote-magic
