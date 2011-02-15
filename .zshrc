# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="fishy"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
#plugins=(ruby gem rails git github command-not-found)
plugins=(command-not-found git zsh-syntax-highlighting zsh-history-substring-search)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export EDITOR='vim'
export PAGER='env LESSOPEN= less -Rf'

test "$TERM" = xterm &&
export TERM=xterm-256color

setopt histignorealldups

ZSH_HIGHLIGHT_STYLES[default]='none'
ZSH_HIGHLIGHT_STYLES[isearch]='fg=magenta,standout'
ZSH_HIGHLIGHT_STYLES[special]='fg=magenta,standout'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[alias]='fg=green'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=green'
ZSH_HIGHLIGHT_STYLES[function]='fg=green'
ZSH_HIGHLIGHT_STYLES[command]='fg=green'
ZSH_HIGHLIGHT_STYLES[path]='underline'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=blue'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='bold'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='bold'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=cyan'

test -s ~/app/paths || cat > ~/app/paths <<EOF
export PATH=\$PATH:$(ls -d ~/app/**/bin/ | tr '\n' ':')
export MANPATH=\$MANPATH:$(ls -d ~/app/**/man/ | tr '\n' ':')
EOF
source ~/app/paths
export GEM_HOME=~/app/gems

duh() {
  test $# -eq 0 && set -- *
  du -sch "$@" | sort -h
}

alias e='$EDITOR'
alias ec='edit-merge-conflict'
alias ls='ls --color=tty --human-readable'
alias lt='ls -ltr'
alias mv='mv -i'
alias open='xdg-open'
alias rm='rm -i'
alias RM='rm -rf'
alias scp='rsync --rsh=ssh -arv'
alias v='$PAGER'
alias x='nice extract-archive'

alias g='git'
alias gA='git add'
alias ga='git add -p'
alias gau='git add -u'
alias gb='git branch -av'
alias gbl='git branch -v'
alias gca='git commit --amend'
alias gci='git commit'
alias gco='git checkout'
alias gcp='git cherry-pick'
alias gd='gD --cached'
alias gD='git diff'
alias gec='ec $(gs | sed -n "s/^.*both [a-z]*ed: *//p")'
alias gi='gl -n 1'
alias gl='git log --name-status'
alias gra='git rebase --abort'
alias grb='git rebase'
alias grc='git rebase --continue'
alias gr='git remote -v'
alias gri='git rebase --interactive'
alias gsa='git stash apply'
alias gs='git status'
alias gsl='git stash list'
alias gst='git stash save'
glf() {
  git log --format='format:* %s. %b'$'\n' "$@" |
  ruby -pe '$_.sub!(/^\* ./) { $&.upcase }' |
  less
}
gur() { # update all git repositories inside the given directories
  for arg in "$@"; do
    for repo in "$arg"/**/.git; do
      echo "$repo"
      pushd "$repo"/..
      git pull origin master
      popd
    done
  done
}

unsetopt auto_name_dirs
source ~/.rvm/scripts/rvm
source ~/.nvm/nvm.sh
cd "$PWD" # trigger .rvmrc loading

test -s $HOME/.zshrc_private &&
source $HOME/.zshrc_private

fortune -s | cowsay
