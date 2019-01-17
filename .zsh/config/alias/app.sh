export PAGER='less' LESS='-iR'

for editor in nvim vim vi; do
  if command -v $editor >/dev/null; then
    export VISUAL=$editor
    break
  fi
done

export SUDO_ASKPASS=/usr/libexec/ssh-askpass
test -e $SUDO_ASKPASS || unset SUDO_ASKPASS

alias open='xdg-open'
alias scp='rsync --archive --update --compress --verbose'
alias sloc='cloc --by-file-by-lang --exclude-dir .git'
alias tree='tree -ACF'
alias grep='grep --perl-regexp --color=auto'

alias a='where'
A() { /usr/bin/which "$@" | xargs -r realpath ;}
alias E='$VISUAL -u NONE -c "set term=ansi smd"'
alias e='$VISUAL'
alias g='grep'
alias H='apropos'
alias h='man'
alias s='$PAGER'
alias t='tee /dev/tty'
