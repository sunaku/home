# o = working copy
alias go='git status'
alias gol='git status --short'
alias god='git diff'
alias gor='git reset --soft'
alias goR='git reset --hard'
alias goc='git clean -n'
alias goC='git clean -fd'
alias gox='git rm'

# i = index / stage
alias gi='git add -p'
alias gia='git add'
alias giu='git add -u'
alias gid='git diff --cached'
alias gir='git reset'
alias giR='git reset --mixed'
alias gix='git rm --cached'

# t = stash
alias gt='git stash save'
alias gtl='git stash list'
alias gtld='git stash list --patch-with-stat'
alias gtb='git stash branch'
alias gta='git stash apply'
alias gtp='git stash pop'
alias gtx='git stash drop'
alias gtX='git stash clear'

# c = commit
alias gc='git commit'
alias gcq='git commit -m "SQUASH $(date)"'
alias gca='git commit --amend'
alias gco='git checkout'
alias gcO='git checkout HEAD --'
alias gcp='git cherry-pick'
alias gcr='git revert'
alias gcR='git reset "HEAD^"'
alias gc1='git show'

# b = branch
alias gb='git checkout -b'
alias gbl='git branch -av'
alias gbL='git branch -v'
alias gbx='git branch -d'
alias gbX='git branch -D'
alias gbm='git branch -m'
alias gbM='git branch -M'

# m = merge
alias gm='git merge --no-ff'
alias gmf='git merge --ff'

# r = rebase
alias gr='git rebase'
alias gri='git rebase --interactive'
alias grc='git rebase --continue'
alias grs='git rebase --skip'
alias gra='git rebase --abort'

# k = conflict
alias gkl='git status --porcelain | sed -n "s/^[^? ][^? ] //p"'
alias gka='git add $(gkl)'
alias gke='edit-merge-conflict $(gkl)'
alias gko='git checkout --ours --'
alias gkO='gko $(gkl)'
alias gkt='git checkout --theirs --'
alias gkT='gkt $(gkl)'

# f = files
alias gfl='git ls-files'
alias gfo='git status --porcelain --short --ignored | sed -n "s/^!! //p"'
alias gfi='git ls-files --cached'
alias gfm='git ls-files --modified'
alias gfu='git ls-files --others'
alias gfx='git ls-files --killed'

# l = log
alias gl='git log --name-status'
alias gll='gl --oneline'
alias gld='git log --patch-with-stat'
alias glc='git reflog'
glcf() { # search reflog for all commits related to the given files
  gl $(git rev-list --all "$@")
}
glcfd() { # search reflog for all commits related to the given files, with diffs
  gld $(git rev-list --all "$@")
}
alias gl1='git log -1'

glp() { # pretty git changelog
  git log --format='format:* %s. %b'$'\n' "$@" |
  ruby -pe '$_.sub!(/^\* ./) { $&.upcase }' |
  less
}

# h = remote hosts
alias ghl='git remote -v'
alias gha='git remote add'
alias ghx='git remote rm'

# p = push
alias gp='git push'
alias gpf='git push --force'
alias gpt='git push --tags'

# g = fetch
alias gg='git fetch'
alias ggm='git pull'
alias ggr='git pull --rebase'

# u = submodule
alias gul='git submodule'
alias gua='git submodule add'
alias guR='git submodule update'
alias gug='git submodule sync'
