# navigate
alias -- -='cd -'
alias -- _='dirs -v'

u() { # go Up a directory $1 times (default: 1)
  cd $(seq ${1:-1} | sed 's|.*|../|' | tr -d '\n')
}

# inspect
alias ls='ls -h --color=auto'
alias .,='ls-summary'
alias ,.,='ls-lineage'
alias ,..='ls-sizetime -Ahtr'
if command -v exa >/dev/null; then
  exa='exa -lgH'
  alias ,="$exa -a -snew"
  alias ,.="$exa -d"
  alias ,,="$exa -TD"
  alias ,,,="$exa -T"
else
  alias ,='ls -Altr'
  alias ,.='ls -ld'
  alias ,,='tree -d'
  alias ,,,='tree'
fi

# modify
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

mkd() { # Make Dir and go in
  mkdir -vp "$@"
  if test $# -eq 1; then
    cd "$1"
  fi
}

mov() { # rename & redirect
  mv -vbi "$1" "$2" &&
  ln -vsf "$2" "$1"
}

bam() { # backup with move
  for file; do
    file=${file%/}
    mv -v "$file" "$file"~
  done
}

bum() { # undo backup move
  for file; do
    file=${file%/}
    mv -vT "$file" "${file%\~}"
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
