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
