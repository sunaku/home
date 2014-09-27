alias -- -='cd -'
alias ,=ll
alias ,,=lc
alias ,.=la
alias ls='ls -h --color=auto'
alias ll='ls -ltr'
alias la='ll -A'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias RM='rm -vfr'

lc() {
  test $# -eq 0 && set -- .
  for argument; do
    listing=$(ls -1F "$argument")
    total=$(echo "$listing" | wc -l)
    echo -n "$argument: $total total"

    folders=$(echo "$listing" | grep -c '/$')
    test $folders -gt 0 && echo -n ", $folders folders"

    files=$(echo "$listing" | grep -c '[^*/=>@|]$')
    test $files -gt 0 && echo -n ", $files files"

    symlinks=$(echo "$listing" | grep -c '@$')
    test $symlinks -gt 0 && echo -n ", $symlinks symlinks"

    executables=$(echo "$listing" | grep -c '\*$')
    test $executables -gt 0 && echo -n ", $executables executables"

    sockets=$(echo "$listing" | grep -c '=$')
    test $sockets -gt 0 && echo -n ", $sockets sockets"

    whiteouts=$(echo "$listing" | grep -c '>$')
    test $whiteouts -gt 0 && echo -n ", $whiteouts whiteouts"

    pipes=$(echo "$listing" | grep -c '|$')
    test $pipes -gt 0 && echo -n ", $pipes pipes"

    echo
  done
}

duh() { # disk usage for humans
  test $# -eq 0 && set -- *
  du -sch "$@" | sort -h
}

alias tree='tree -ACF'

bam() { # backup with move
  for file; do
    file=${file%/}
    mv -v $file{,.bak}
  done
}

bum() { # undo backup move
  for file; do
    file=${file%/}
    test "${file%.bak}" = "$file" && file="$file.bak"
    mv -v "$file" "${file%.bak}"
  done
}

bac() { # backup with copy
  for file; do
    file=${file%/}
    cp -Rpv "$file" "$file~$(date -Ins)~"
  done
}

buc() { # undo backup copy
  for file; do
    file=${file%/}
    dest=${file%%\~*}
    test -d "$dest" && mv -v "$dest" "$file.orig"
    mv -v "$file" "$dest"
  done
}

mount-dir-ro() {
  sudo mount --bind "$@" &&
  sudo mount -o remount,ro,bind "$@"
}
