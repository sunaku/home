if test "$TERM" != linux; then
  # show current command, directory, and user in terminal title
  precmd()  { print -Pn "\e]2;$0 (%~) %n@%m\a" 2>/dev/null }
  preexec() { print -Pn "\e]2;$1 (%~) %n@%m\a" 2>/dev/null }
fi
