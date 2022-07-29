#
# configs
#

multisource() {
  for each; do
    source $each
  done
}

multisource ~/.zsh/config/**/*sh

#
# plugins
#

source ~/.zsh/bundle/zsh-snap/znap.zsh

znap source hlissner/zsh-autopair
znap source z-shell/F-Sy-H
znap source z-shell/H-S-MW
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-history-substring-search
znap source Tarrasch/zsh-bd
znap source agkozak/zsh-z

znap source mafredri/zsh-async # for prompt.zsh
source ~/.zsh/prompt.zsh

multisource ~/.zsh/bundle/*.zsh

# undo any config overrides performed by plugins
multisource ~/.zsh/config/**/*sh
