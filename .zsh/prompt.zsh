# my "sunaku" prompt for ZSH using vcs_info with zsh-async
# https://sunaku.github.io/switching-from-fish-to-zsh.html

autoload -Uz add-zsh-hook

#-----------------------------------------------------------------------------
# prompt elements: exit status, SSH login, vcs_info, super user; date and time
#-----------------------------------------------------------------------------

setopt PROMPT_SUBST

PROMPT=\
'%(?..%B%F{red}exit %?%f%b'$'\n'')'\
'${SSH_TTY:+%F{cyan\}%n@%m%f }'\
'${vcs_info_msg_0_}'\
'%(!.%F{red}.%F{green})%~%f'\
'%(!.#.>) '

RPROMPT='%F{magenta}#%F{cyan}%D{%-e%b}%F{yellow}%D{%-l:%M%p}%f'

#-----------------------------------------------------------------------------
# VI keybindings: indicate VI/EMACS mode using cursor styles (DECSCUSR, VT520)
#-----------------------------------------------------------------------------

function zle-line-init zle-keymap-select {
  if [[ $KEYMAP == vicmd ]]; then
    _zsh_prompt_block_cursor
  else
    _zsh_prompt_bar_cursor
  fi
}
zle -N zle-line-init
zle -N zle-keymap-select

_zsh_prompt_default_cursor() { print -n "\e[0 q" }
_zsh_prompt_block_cursor()   { print -n "\e[2 q" }
_zsh_prompt_bar_cursor()     { print -n "\e[6 q" }

add-zsh-hook preexec _zsh_prompt_default_cursor

#-----------------------------------------------------------------------------
# VCS integration for command prompt using vcs_info
#-----------------------------------------------------------------------------

# https://github.com/zsh-users/zsh/blob/master/Misc/vcs_info-examples
autoload -Uz vcs_info
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr     '%B%F{green}$%f%b'
zstyle ':vcs_info:*' unstagedstr   '%B%F{yellow}%%%f%b'
zstyle ':vcs_info:*' formats       '%c%u%b%m '
zstyle ':vcs_info:*' actionformats '%c%u%b %F{yellow}%m%f %B%s-%a%%b '
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked git-aheadbehind git-remotebranch

### git: Show marker (T) if there are untracked files in repository
# Make sure you have added staged to your 'formats':  %c
function +vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git --no-optional-locks status --porcelain | grep -q '^?? ' 2> /dev/null ; then
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

    # Exit early in case the worktree is on a detached HEAD
    git rev-parse ${hook_com[branch]}@{upstream} >/dev/null 2>&1 || return 0

    local -a ahead_and_behind=(
        $(git rev-list --left-right --count HEAD...${hook_com[branch]}@{upstream} 2>/dev/null)
    )

    ahead=${ahead_and_behind[1]}
    behind=${ahead_and_behind[2]}

    (( $ahead )) && gitstatus+=( "%B%F{blue}+${ahead}%f%b" )
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
        hook_com[branch]="${hook_com[branch]}%F{yellow}=%f%F{blue}${remote}%f"
    fi
}

#-----------------------------------------------------------------------------
# asynchronous vcs_info using zsh-async workers
#-----------------------------------------------------------------------------

# https://vincent.bernat.ch/en/blog/2019-zsh-async-vcs-info
_zsh_prompt_async_vcs_info() {
  async_job vcs_info _zsh_prompt_async_vcs_info_job $PWD
}

_zsh_prompt_async_vcs_info_job() {
  cd -q $1
  vcs_info
  print $vcs_info_msg_0_
}

_zsh_prompt_async_vcs_info_start() {
  async_start_worker vcs_info
  async_register_callback vcs_info _zsh_prompt_async_vcs_info_done
}

_zsh_prompt_async_vcs_info_stop() {
  async_unregister_callback vcs_info
  async_stop_worker vcs_info
}

_zsh_prompt_async_vcs_info_done() {
  if [ $2 -eq 0 ]; then
    vcs_info_msg_0_=$3 # stdout
    zle reset-prompt
  else
    _zsh_prompt_async_vcs_info_stop
    _zsh_prompt_async_vcs_info_start
  fi
}

# https://github.com/mafredri/zsh-async
async_init
_zsh_prompt_async_vcs_info_start
add-zsh-hook precmd _zsh_prompt_async_vcs_info
