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

# http://zsh.git.sourceforge.net/git/gitweb.cgi?p=zsh/zsh;a=blob_plain;f=Misc/vcs_info-examples

### git: Show marker (T) if there are untracked files in repository
# Make sure you have added staged to your 'formats':  %c
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        # This will show the marker if there are any untracked files in repo.
        # If instead you want to show the marker only if there are untracked
        # files in $PWD, use:
        #[[ -n $(git ls-files --others --exclude-standard) ]] ; then
        hook_com[staged]+='?'
    fi
}

### git: Show +N/-N when your local branch is ahead-of or behind remote HEAD.
# Make sure you have added misc to your 'formats':  %m
zstyle ':vcs_info:git*+set-message:*' hooks git-aheadbehind
function +vi-git-aheadbehind() {
    local ahead behind
    local -a gitstatus

    # for git prior to 1.7
    # ahead=$(git rev-list origin/${hook_com[branch]}..HEAD | wc -l)
    ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l)
    (( $ahead )) && gitstatus+=( "+${ahead}" )

    # for git prior to 1.7
    # behind=$(git rev-list HEAD..origin/${hook_com[branch]} | wc -l)
    behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l)
    (( $behind )) && gitstatus+=( "-${behind}" )

    hook_com[misc]+=${(j:/:)gitstatus}
}

### git: Show remote branch name for remote-tracking branches
# Make sure you have added staged to your 'formats':  %b
zstyle ':vcs_info:git*+set-message:*' hooks git-remotebranch
function +vi-git-remotebranch() {
    local remote

    # Are we on a remote-tracking branch?
    remote=${$(git rev-parse --verify ${hook_com[branch]}@{upstream} \
        --symbolic-full-name 2>/dev/null)/refs\/remotes\/}

    if [[ -n ${remote} && ${remote#*/} != ${hook_com[branch]} ]] ; then
        hook_com[branch]="${hook_com[branch]}(${remote})"
    fi
}

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
