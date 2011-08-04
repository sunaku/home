# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="sunaku"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(zsh-syntax-highlighting zsh-history-substring-search)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

#-----------------------------------------------------------------------------
# appearance
#-----------------------------------------------------------------------------

ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='bold'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='bold'

if test $TERM != linux; then
  HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=yellow,standout'
  HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='fg=red,standout'
fi

# show current command, directory, and user in terminal title
precmd()  { print -Pn "\e]2;$0 (%~) %n@%m\a" }
preexec() { print -Pn "\e]2;$1 (%~) %n@%m\a" }

#-----------------------------------------------------------------------------
# interaction
#-----------------------------------------------------------------------------

# bind special keys according to readline configuration
eval "$(sed -n 's/^/bindkey /; s/: / /p' /etc/inputrc)"

# do not erase entire line when Control-U is pressed
bindkey '^U' backward-kill-line

setopt histignorealldups

source ~/.aliases
setopt nocompletealiases      # treat `gco` like `git checkout`
compdef _git tig=git-checkout # treat `tig` like `git checkout`
compdef hub=git               # treat `hub` like `git`

#-----------------------------------------------------------------------------
# plugins
#-----------------------------------------------------------------------------

# Ruby Version Manager
unsetopt auto_name_dirs
source ~/.rvm/scripts/rvm
cd $PWD # trigger .rvmrc loading

# Node Version Manager
source ~/.nvm/nvm.sh

# fortune cookie ;-)
fortune -s | cowsay
