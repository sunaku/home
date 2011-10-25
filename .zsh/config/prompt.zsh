# my "sunaku" prompt for ZSH using vcs_info stdlib
# http://snk.tuxfamily.org/log/sunaku-zsh-prompt.png

PROMPT='%(?..%B%F{red}exit %?%f%b
)'\
'$(vcs_info && echo $vcs_info_msg_0_)'\
"%F{$(test $UID -eq 0 && echo red || echo green)}%~%f"\
'%(!.#.>) '

RPROMPT='%F{cyan}%@%f'

# VCS integration for command prompt using vcs_info
# http://zsh.git.sourceforge.net/git/gitweb.cgi?p=zsh/zsh;a=blob_plain;f=Misc/vcs_info-examples

autoload -Uz vcs_info
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr     '%B%F{green}$%f%b'
zstyle ':vcs_info:*' unstagedstr   '%B%F{yellow}!%f%b'
zstyle ':vcs_info:*' formats       '%c%u%b%m '
zstyle ':vcs_info:*' actionformats '%c%u%b%m %B%s-%a%%b '
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked git-aheadbehind git-remotebranch

### git: Show marker (T) if there are untracked files in repository
# Make sure you have added staged to your 'formats':  %c
function +vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        # This will show the marker if there are any untracked files in repo.
        # If instead you want to show the marker only if there are untracked
        # files in $PWD, use:
        #[[ -n $(git ls-files --others --exclude-standard) ]] ; then
        hook_com[unstaged]+='%B%F{magenta}?%f%b'
    fi
}

### git: Show +N/-N when your local branch is ahead-of or behind remote HEAD.
# Make sure you have added misc to your 'formats':  %m
function +vi-git-aheadbehind() {
    local ahead behind
    local -a gitstatus

    # for git prior to 1.7
    # ahead=$(git rev-list origin/${hook_com[branch]}..HEAD | wc -l)
    ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l)
    (( $ahead )) && gitstatus+=( "%B%F{blue}+${ahead}%f%b" )

    # for git prior to 1.7
    # behind=$(git rev-list HEAD..origin/${hook_com[branch]} | wc -l)
    behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l)
    (( $behind )) && gitstatus+=( "%B%F{red}-${behind}%f%b" )

    hook_com[misc]+=${(j::)gitstatus}
}

### git: Show remote branch name for remote-tracking branches
# Make sure you have added staged to your 'formats':  %b
function +vi-git-remotebranch() {
    local remote

    # Are we on a remote-tracking branch?
    remote=${$(git rev-parse --verify ${hook_com[branch]}@{upstream} \
        --symbolic-full-name 2>/dev/null)/refs\/remotes\/}

    # The first test will show a tracking branch whenever there is one. The
    # second test, however, will only show the remote branch's name if it
    # differs from the local one.
    #if [[ -n ${remote} ]] ; then
    if [[ -n ${remote} && ${remote#*/} != ${hook_com[branch]} ]] ; then
        hook_com[branch]="${hook_com[branch]}(%F{cyan}${remote}%f)"
    fi
}
