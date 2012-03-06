# o = working copy
alias go='git status'
alias gol='git status --short'
alias god='git diff'
alias gor='git reset --soft'
alias goR='git reset --hard'
alias goc='git clean -n'
alias goC='git clean -fd'
alias gox='git rm -r --ignore-unmatch'
alias gou='git status --porcelain | sed -n "s/^?? *//p"'

# i = index / stage
alias gi='git add -p'
alias gia='git add'
alias giu='git add -u'
alias gid='git diff --cached'
alias gir='git reset'
alias giR='git reset --mixed'
alias gix='git rm -r --cached --ignore-unmatch'

# t = stash
alias gt='git stash save -p'
alias gT='git stash save'
alias gTo='git stash save && git stash apply'
alias gtl='git stash list'
alias gtL='git stash list --patch-with-stat'
alias gtb='git stash branch'
alias gto='git stash apply'
alias gtO='git stash pop'
alias gtx='git stash drop'
alias gtX='git stash clear'

# c = commit
alias gc='git commit'
alias gcd='git commit --date'
function gcdf() { git commit --date="$(date -r "$1")"; }
function gcv() { git commit -m "Version $1" && git tag "v$1"; }
function gcV() { git tag -f "v$1"; }
alias gcq='git commit -m "SQUASH $(date)"'
alias gca='git commit --amend'
alias gcA='git commit --amend --reuse-message=HEAD'
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
gb1() { # print current branch name
  git symbolic-ref -q "${1:-HEAD}" | sed 's,^refs/heads/,,'
}
gbH() { # set upstream branch for tracking
  branch=$(gb1)
  remote=${1:-origin}
  echo "$remote" | fgrep -vq "/" && remote="$remote/$branch"
  git branch --set-upstream "$branch" "$remote"
}

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
alias gkl='git ls-files --unmerged | cut -f2 | uniq'
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
alias gl1='gl -1'
alias gll='gl --oneline'
alias gld='gl --patch-with-stat'
glp() { # pretty git changelog
  git log --format='format:  * %s. %b'$'\n' "$@"
}

# L = reflog
alias gL='git reflog'
gLc() { # search reflog for all commits related to the given files
  gl $(git rev-list --all "$@")
}
gLC() { # search reflog for all commits related to the given files, with diffs
  gld $(git rev-list --all "$@")
}

# h = remote hosts
alias ghl='git remote -v'
alias gha='git remote add'
alias ghx='git remote rm'

# p = push
alias gp='git push'
alias gP='git push --force'
alias gpt='git push --tags'
alias gPt='git push --tags --force'

# g = fetch
alias gg='git fetch'
alias ggm='git pull'
alias ggr='git pull --rebase'

# u = submodule
alias gul='git submodule'
alias gua='git submodule add'
alias guR='git submodule update'
alias gug='git submodule sync'
