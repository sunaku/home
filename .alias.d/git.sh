# http://neurotap.blogspot.com/2012/04/character-level-diff-in-git-gui.html
intra_line_diff='--word-diff-regex="[^[:space:]]|([[:alnum:]]|UTF_8_GUARD)+"'

#-----------------------------------------------------------------------------
# o = working copy
#-----------------------------------------------------------------------------

# show status of working copy
alias go='git status'

# show status of files in working copy
alias gol='git status --short'

# diff working copy against current commit
alias god='git diff'

# ... while showing changes within a line
alias goD='god '$intra_line_diff

# reset working copy to current index
alias gor='git reset --soft'

# reset working copy to upstream state
alias gorh='git reset --soft @{u}'

# reset working copy to current commit
alias goR='git reset --hard'

# reset working copy to upstream state
alias goRh='git reset --hard @{u}'

# stage deletion and also delete from working copy
alias gox='git rm -r --ignore-unmatch'

# list unknown files in working copy
alias gou='git status --porcelain | sed -n "s/^?? *//p"'

# list unknown files in working copy that can be deleted
alias goc='git clean -n'

# delete unknown files from working copy
alias goC='git clean -f'

#-----------------------------------------------------------------------------
# i = index / stage
#-----------------------------------------------------------------------------

# stage changes interactively (like Darcs!)
alias gi='git add -p'

# stage all changes in target
alias gia='git add'

# stage all changes in working copy
alias giu='git add -u'

# diff index against current commit
alias gid='git diff --cached'

# ... while showing changes within a line
alias giD='gid '$intra_line_diff

# unstage changes from index but keep them in working copy
alias gir='git reset'

# unstage changes from both index and working copy
alias giR='git reset --mixed'

# stage deletion without changing working copy
alias gix='git rm -r --cached --ignore-unmatch'

#-----------------------------------------------------------------------------
# t = stash
#-----------------------------------------------------------------------------

# stash current state and reset working copy to current commit
alias gt='git stash save'

# stash current state but keep working copy as-is
alias gT='git stash save && git stash apply'

# list all stashes
alias gtl='git stash list'

# list all stashes with diffs
alias gtL='git stash list --patch-with-stat'

# create new branch from stash
alias gtb='git stash branch'

# unstash to working copy but keep stash
alias gto='git stash apply'

# unstash to working copy and delete stash
alias gtO='git stash pop'

# delete stash
alias gtx='git stash drop'

# delete all stashes
alias gtX='git stash clear'

#-----------------------------------------------------------------------------
# c = commit
#-----------------------------------------------------------------------------

# commit staged changes
alias gc='git commit'

# commit staged changes with the given message
alias gcm='git commit -m'

# commit staged changes as if on the given date
alias gcd='git commit --date'

# commit staged changes as if on the modification date of the given file
function gcdf() {
  git commit --date="$(date -r "$1")"
}

# commit staged changes with the given version string as the message
function gcv() {
  git commit -m "Version $1" && git tag "v$1"
}
function gcV() {
  git tag -f "v$1"
}

# commit staged changes to a temporary "squash" commit, to be rebased later
alias gcq='git commit -m "SQUASH $(date)"'

# amend current commit and edit its message
alias gca='git commit --amend'

# amend current commit but reuse its message
alias gcA='git commit --amend --reuse-message=HEAD'

# commit an inverse commit to revert changes from the given commit
alias gcr='git revert'

# delete current commit but keep its changes in working copy
alias gcR='git reset "HEAD^"'

# check out changes from current commit
alias gco='git checkout'

# update working copy to current commit
alias gcO='git checkout HEAD --'

# cherry pick the given commit into current branch
alias gcp='git cherry-pick'
alias gcpc='git cherry-pick --continue'
alias gcpa='git cherry-pick --abort'
alias gcps='git cherry-pick --skip'

# show current commit in detail
alias gc1='git show'

#-----------------------------------------------------------------------------
# b = branch
#-----------------------------------------------------------------------------

# create branch with given name
alias gb='git checkout -b'

# list all branches
alias gbl='git branch -av'

# list all branches with commit details
alias gbL='git branch -v'

# delete merged branch
alias gbx='git branch -d'

# delete branch forcefully
alias gbX='git branch -D'

# rename current branch to given namee
alias gbm='git branch -m'

# rename current branch to given name forcefully
alias gbM='git branch -M'

# show current branch name
# http://stackoverflow.com/a/9753364
gb1() {
  git symbolic-ref --short HEAD
}

# show current remote branch name
# http://stackoverflow.com/a/9753364
gbh() {
  git rev-parse --abbrev-ref '@{u}'
}

# set upstream branch for tracking
gbH() {
  branch=$(gb1)
  remote=${1:-origin}
  echo "$remote" | fgrep -vq "/" && remote="$remote/$branch"
  git branch -u "$remote" "$branch"
}

#-----------------------------------------------------------------------------
# m = merge
#-----------------------------------------------------------------------------

# merge commits
alias gm='git merge --no-ff'

# merge commits but don't record a special merge commit
alias gmf='git merge --ff'

#-----------------------------------------------------------------------------
# r = rebase
#-----------------------------------------------------------------------------

alias gr='git rebase'
alias gri='git rebase --interactive'
alias grc='git rebase --continue'
alias gra='git rebase --abort'
alias grs='git rebase --skip'
alias grh='gr @{u}' # against upstream branch

#-----------------------------------------------------------------------------
# k = conflict
#-----------------------------------------------------------------------------

# list all conflicted files
alias gkl='git ls-files --unmerged | cut -f2 | uniq'

# add changes from all conflicted files
alias gka='git add $(gkl)'

# edit conflicted files
alias gke='edit-merge-conflict $(gkl)'

# use local version of the given files
alias gko='git checkout --theirs --'

# use local version of all conflicted files
alias gkO='gko $(gkl)'

# use upstream version of the given files
alias gkt='git checkout --ours --'

# use upstream version of all conflicted files
alias gkT='gkt $(gkl)'

#-----------------------------------------------------------------------------
# f = files
#-----------------------------------------------------------------------------

# list all known files
alias gfl='git ls-files'

# list ignored files
alias gfo='git status --porcelain --short --ignored | sed -n "s/^!! //p"'

# list staged files
alias gfi='git ls-files --cached'

# list modified files
alias gfm='git ls-files --modified'

# list unknown files
alias gfu='git ls-files --others'

# list deleted files
alias gfx='git ls-files --killed'

#-----------------------------------------------------------------------------
# l = log
#-----------------------------------------------------------------------------

# show commit log
alias gl='git log --decorate --graph'

# show most recent log entry
alias gl1='glf -1'

# show log with affected files
alias glf='gl --name-status'

# show log like `ls -l`
alias gll='gl --oneline'

# show log with diffs
alias gld='gl --patch-with-stat'

# ... while showing changes within a line
alias glD='gld '$intra_line_diff

# pretty git changelog
glp() {
  git log --pretty='  * %s. %b'$'\n' "$@"
}

#-----------------------------------------------------------------------------
# L = reflog
#-----------------------------------------------------------------------------

# show reference log
alias gL='git reflog --decorate'

alias gLL='gll `gL --pretty=%h`'

# search reflog for all commits related to the given files
gLf() {
  gl $(git rev-list --all "$@")
}

# search reflog for all commits related to the given files, show with diffs
gLfd() {
  gld $(git rev-list --all "$@")
}

#-----------------------------------------------------------------------------
# h = remote hosts
#-----------------------------------------------------------------------------

# list all remotes
alias ghl='git remote -v'

# add remote
alias gha='git remote add'

# delete remote
alias ghx='git remote rm'

# show current remote name
# http://stackoverflow.com/a/7251377
alias gh1='git config branch.$(gb1).remote'

# show current remote URL
# http://stackoverflow.com/a/7251377
alias gh2='git config remote.$(gh1).url'

# diff remote tracking branch
alias ghd='git diff @{u}'

# ... while showing changes within a line
alias ghD='ghd '$intra_line_diff

#-----------------------------------------------------------------------------
# p = push
#-----------------------------------------------------------------------------

# push commits
alias gp='git push'

# push commits forcefully
alias gP='git push --force'

# push tags
alias gpt='git push --tags'

# push tags forcefully
alias gPt='git push --tags --force'

#-----------------------------------------------------------------------------
# g = fetch
#-----------------------------------------------------------------------------

# fetch commits
alias gg='git fetch'

# fetch and merge commits
alias ggm='git pull'

# fetch and rebase commits
alias ggr='git pull --rebase'

#-----------------------------------------------------------------------------
# u = submodule
#-----------------------------------------------------------------------------

# list all submodules
alias gul='git submodule'

# add submodule
alias gua='git submodule add'

# reset submodules to known state
alias guR='git submodule update'

# register new URLs for submodules
alias gug='git submodule sync'
