#
# ZSH Line Editor
#
# http://zsh.sourceforge.net/Doc/Release/Options.html#Zle
#
setopt BEEP

# use EMACS-style keybindings for command line editing
bindkey -e

# ...while allowing activation of VI-style keybindings
bindkey "^[" vi-cmd-mode # hit Escape to enter VI mode
KEYTIMEOUT=15 # 0.15 seconds delay for switching modes

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

# run command using sudo(1)
function _run_with_sudo {
  BUFFER="sudo $BUFFER"
  zle accept-line
}
zle -N _run_with_sudo
bindkey '^XR' _run_with_sudo

# replace command with pager
function _run_with_pager {
  local command="$PAGER ${BUFFER#* }"
  zle push-line
  BUFFER=$command
  zle accept-line
}
zle -N _run_with_pager
bindkey '^Xr' _run_with_pager

# pipe command to pager
function _pipe_to_pager {
  zle end-of-line
  zle -U " | $PAGER"
}
zle -N _pipe_to_pager
bindkey '^Xs' _pipe_to_pager

# peek while piping to pager
function _peek_to_pager {
  zle end-of-line
  zle -U " | tee /dev/tty | $PAGER"
}
zle -N _peek_to_pager
bindkey '^XS' _peek_to_pager

# insert /dev/null
function _insert_dev_null {
  zle -U '/dev/null'
}
zle -N _insert_dev_null
bindkey '^Xn' _insert_dev_null
