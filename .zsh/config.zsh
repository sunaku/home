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
znap source zdharma/fast-syntax-highlighting
znap source zdharma/history-search-multi-word
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-history-substring-search
znap source Tarrasch/zsh-bd
znap source agkozak/zsh-z

znap source mafredri/zsh-async # for prompt.zsh
source ~/.zsh/prompt.zsh

multisource ~/.zsh/bundle/*.zsh
