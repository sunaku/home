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
plugins=(zsh-history-substring-search zsh-syntax-highlighting) # git github ruby gem rails)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
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

# bind special keys according to readline configuration
eval "$(sed -n 's/^/bindkey /; s/: / /p' /etc/inputrc)"

# do not erase entire line when Control-U is pressed
bindkey '^U' backward-kill-line

# show current command, directory, and user in terminal title
precmd()  { print -Pn "\e]2;$0 (%~) %n@%m\a" }
preexec() { print -Pn "\e]2;$1 (%~) %n@%m\a" }

export PAGER='less -LR'
export EDITOR='vim'

source ~/.aliases
setopt histignorealldups
setopt nocompletealiases # treat gco like git checkout
compdef _git tig=git-checkout # treat tig like git checkout
fortune -s | cowsay

unsetopt auto_name_dirs
source ~/.rvm/scripts/rvm
source ~/.nvm/nvm.sh
cd "$PWD" # trigger .rvmrc loading
