#-----------------------------------------------------------------------------
# defaults
#-----------------------------------------------------------------------------

# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=9999
SAVEHIST=9999
setopt appendhistory autocd nomatch notify
bindkey -e
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename ~/.zshrc
autoload -Uz compinit
compinit
# End of lines added by compinstall

# stuff from default oh-my-zsh configuration
setopt alwaystoend
setopt autocd
setopt autopushd
setopt cdablevars
setopt completeinword
setopt correctall
setopt extendedglob
setopt extendedhistory
setopt noflowcontrol
setopt histexpiredupsfirst
setopt histignorealldups
setopt histignoredups
setopt histignorespace
setopt histverify
setopt incappendhistory
setopt interactive
setopt kshglob
setopt longlistjobs
setopt monitor
setopt promptsubst
setopt pushdignoredups
setopt sharehistory

#-----------------------------------------------------------------------------
# appearance
#-----------------------------------------------------------------------------

# show current command, directory, and user in terminal title
precmd()  { print -Pn "\e]2;$0 (%~) %n@%m\a" }
preexec() { print -Pn "\e]2;$1 (%~) %n@%m\a" }

# my "sunaku" prompt from oh-my-zsh (see http://ompldr.org/vOHcwZg)
PROMPT='%(?..%B%F{red}exit %?%f%b
)'\
'$(vcs_info && echo $vcs_info_msg_0_)'\
"%F{$(test $UID -eq 0 && echo red || echo green)}%~%f"\
'%(!.#.>) '
RPROMPT='%F{cyan}%@%f'

# VCS integration for ZSH command prompt
autoload -Uz vcs_info
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr     '%F{green}+%f'
zstyle ':vcs_info:*' unstagedstr   '%F{yellow}!%f'
zstyle ':vcs_info:*' formats       '%B%c%u%m%%b%b '
zstyle ':vcs_info:*' actionformats '%B%c%u%m%%b%b %B%F{red}%s:%a%f%%b '

#-----------------------------------------------------------------------------
# interaction
#-----------------------------------------------------------------------------

# bind special keys according to readline configuration
eval "$(sed -n 's/^/bindkey /; s/: / /p' /etc/inputrc)"

# do not erase entire line when Control-U is pressed
bindkey '^U' backward-kill-line

# keep command history unique to fit more items in it!
setopt histignorealldups

source ~/.alias
setopt nocompletealiases      # treat `gco` like `git checkout`
compdef _git tig=git-checkout # treat `tig` like `git checkout`
compdef hub=git               # treat `hub` like `git`

#-----------------------------------------------------------------------------
# plugins
#-----------------------------------------------------------------------------

# zsh-syntax-highlighting
source ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='bold'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='bold'

# zsh-history-substring-search
source ~/.zsh-history-substring-search/zsh-history-substring-search.zsh
if test $TERM != linux; then
  HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=yellow,standout'
  HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='fg=red,standout'
fi

# Ruby Version Manager
unsetopt auto_name_dirs
source ~/.rvm/scripts/rvm
cd $PWD # trigger .rvmrc loading

# Node Version Manager
source ~/.nvm/nvm.sh

#-----------------------------------------------------------------------------
# welcome
#-----------------------------------------------------------------------------

# fortune cookie ;-)
fortune -s | cowsay
