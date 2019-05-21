if test "$TERM" != linux; then
  # show current command, directory, and user in terminal title
  _zsh_config_reset_title()  { print -Pn "\e]2;$0 (%~) %n@%m\a" }
  _zsh_config_update_title() { print -Pn "\e]2;$1 (%~) %n@%m\a" }

  autoload -Uz add-zsh-hook
  add-zsh-hook precmd  _zsh_config_reset_title
  add-zsh-hook preexec _zsh_config_update_title
fi
