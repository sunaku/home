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
znap source zsh-users/zsh-syntax-highlighting
znap source zdharma/history-search-multi-word
znap source zsh-users/zsh-autosuggestions
znap source marlonrichert/zsh-autocomplete
znap source agkozak/zsh-z

znap source marlonrichert/zcolors
znap eval zcolors "zcolors ${(q)LS_COLORS}"

znap source mafredri/zsh-async # for prompt.zsh
source ~/.zsh/prompt.zsh

multisource ~/.zsh/bundle/*.zsh
