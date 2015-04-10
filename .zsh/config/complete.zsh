#
# Completion
#
# http://zsh.sourceforge.net/Doc/Release/Options.html#Completion-4
#
setopt ALWAYS_TO_END
setopt AUTO_LIST
setopt AUTO_MENU
setopt AUTO_PARAM_SLASH
setopt AUTO_REMOVE_SLASH
setopt COMPLETE_IN_WORD
setopt GLOB_COMPLETE
setopt LIST_PACKED
setopt MENU_COMPLETE

# TAB-complete partial file names or paths
# http://www.rayninfo.co.uk/tips/zshtips.html
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# highlight the currently active menu choice
# http://www.masterzen.fr/tag/linux/
zstyle ':completion:*' menu select

# The following lines were added by compinstall
zstyle :compinstall filename ~/.zshrc
autoload -Uz compinit
compinit
# End of lines added by compinstall
