# http://blog.viridian-project.de/2008/07/03/zsh-tip-handling-urls-with-url-quote-magic/
autoload -U url-quote-magic
zle -N self-insert url-quote-magic
