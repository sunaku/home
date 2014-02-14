# Lets you inject tmux environment into existing shells via SIGUSR1.
# For example, to update all existing ZSH sessions: `pkill -USR1 zsh`
function eval-tmux-environment() {
  eval $(tmux show-environment | sed 's/^\w/export "&/; s/^-/unset "/; s/$/"/')
}
trap eval-tmux-environment SIGUSR1
