# navigate
alias -- -='cd -'
alias -- _='dirs -v'

u() { # go Up a directory $1 times (default: 1)
  cd $(seq ${1:-1} | sed 's|.*|../|' | tr -d '\n')
}

# inspect
alias ls='ls -h --color=auto'
alias ,='ls -Altr'
alias ,.='ls -ld'
alias .,='ls-summary'
alias ,.,='ls-lineage'
alias ,..='ls-sizetime -Ahtr'
alias ,,='tree -d'
alias ,,,='tree'
if command -v exa >/dev/null; then
  alias ,='exa -l -snew'
  alias ,.='exa -ld'
  alias ,,='exa -lTD'
  alias ,,,='exa -lT'
fi

# modify
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

mkdir() { # Make Dir and go in
  for dir; do
    command mkdir -vp "$dir"
  done
  test $# -eq 1 && cd "$1" ||:
}

mov() { # rename & redirect
  mv -vbi "$1" "$2" &&
  ln -vsf "$2" "$1"
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
