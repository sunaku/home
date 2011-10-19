# show current command, directory, and user in terminal title
precmd()  { print -Pn "\e]2;$0 (%~) %n@%m\a" }
preexec() { print -Pn "\e]2;$1 (%~) %n@%m\a" }
