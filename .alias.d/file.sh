alias -- -='cd -'
alias ,=ll
alias ,.=la
alias ls='ls -h --color=auto'
alias ll='ls -ltr'
alias la='ll -A'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias RM='rm -vfr'

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
