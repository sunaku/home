export PAGER='less' LESS='-iR'
export VISUAL='editor'

# shim for many kinds of VISUAL
editor() {
  for editor in nvim vim vi; do
    command $editor "$@"
    case $? in
      (126|127) continue ;;
      (*)       return ;;
    esac
  done
}

alias open='xdg-open'
alias scp='rsync --archive --update --compress --verbose'
alias sloc='cloc --by-file-by-lang --exclude-dir .git'
alias diff='git diff --no-index --'
alias wdiff='git diff --no-index --word-diff=color --'
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
