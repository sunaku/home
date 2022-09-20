if test "$TERM" != linux; then
  # show current command, directory, and user in terminal title
  _zsh_config_set_title()    { print -Pn "\e]2;$1 (%~) %n@%m\a" }
  _zsh_config_reset_title()  { _zsh_config_set_title "$ZSH_NAME" }
  _zsh_config_update_title() { _zsh_config_set_title "$1" }

  autoload -Uz add-zsh-hook
  add-zsh-hook precmd  _zsh_config_reset_title
  add-zsh-hook preexec _zsh_config_update_title
fi
