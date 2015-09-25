test -f ~/.alias && source ~/.alias

alias -g PAGE='| $PAGER'
alias -g PEEK='| tee /dev/tty PAGE'

# replace command with pager
function _run_with_pager {
  BUFFER="$PAGER ${BUFFER#* }"
  zle accept-line
}
zle -N _run_with_pager
bindkey '^Xr' _run_with_pager

# pipe command to pager
function _pipe_to_pager {
  zle end-of-line
  zle -U ' PAGE'
}
zle -N _pipe_to_pager
bindkey '^Xs' _pipe_to_pager

# peek while piping to pager
function _peek_to_pager {
  zle end-of-line
  zle -U ' PEEK'
}
zle -N _peek_to_pager
bindkey '^XS' _peek_to_pager

# insert /dev/null
function _insert_dev_null {
  zle -U '/dev/null'
}
zle -N _insert_dev_null
bindkey '^XN' _insert_dev_null
