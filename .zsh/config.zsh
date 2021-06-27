source ~/.zsh/bundle/zsh-snap/znap.zsh

source_configs() {
  for config; do
    source $config
  done
}

znap source mafredri/zsh-async # for prompt.zsh
source_configs ~/.zsh/config/**/*sh

znap source hlissner/zsh-autopair
znap source zsh-users/zsh-syntax-highlighting
znap source zdharma/history-search-multi-word
znap source zsh-users/zsh-autosuggestions
znap source marlonrichert/zsh-autocomplete
znap source agkozak/zsh-z

znap source marlonrichert/zcolors
znap eval zcolors "zcolors ${(q)LS_COLORS}"

source_configs ~/.zsh/bundle/*.zsh
