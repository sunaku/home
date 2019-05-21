#
# Changing Directories
#
# http://zsh.sourceforge.net/Doc/Release/Options.html#Changing-Directories
#
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt PUSHD_TO_HOME

#
# Remembering Recent Directories
#
# http://zsh.sourceforge.net/Doc/Release/User-Contributions.html#Recent-Directories
#
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':completion:*:*:cdr:*:*' menu selection
