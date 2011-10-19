source ~/.alias
setopt nocompletealiases      # treat `gco` like `git checkout`
compdef _git tig=git-checkout # treat `tig` like `git checkout`
compdef hub=git               # treat `hub` like `git`
