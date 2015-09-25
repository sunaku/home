# navigate
alias i='cd'
alias o='cd -'
alias O='dirs -v'
u() { # go up $1 directories
  i=0
  while test $i -lt ${1:-1}; do
    i=$(( i + 1 ))
    cd ..
  done
}

# inspect
alias ls='ls -h --color=auto'
alias ll='ls -ltr'
alias la='ll -A'
alias ,='la'
alias ,.='ll -d'
alias ,,='ls-summary'
alias ,t='tree'

# modify
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias d='rm -r'
alias D='rm -rf'
alias M='mkdir -p'
alias m='mcd'

mcd() { # Make Dir and go in
  mkdir -p "$@" && cd "$@"
}

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
