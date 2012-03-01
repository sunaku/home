if test "${SHELL##*/}" = zsh; then
  alias -g G='| grep'
  alias -g V="| $PAGER"
  alias -g T='| tee /dev/tty |'
  alias -g N='/dev/null'
fi
