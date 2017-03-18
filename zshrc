# .zshrc
#
# Kevin Dungs <kevin@dun.gs>
# 2016-10-22

precmd() {
  vcs_info
  build_prompt
}

export EDITOR="mvim -v"
export LESS=-R
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export PATH=$PATH:$HOME/.local/bin

setopt autocd
setopt correct
setopt extendedglob
setopt hashlistall
setopt nomatch
unsetopt beep
bindkey -e

# Aliases
alias grep="grep --color=always"
alias l="ls -l"
alias la="la -a"
alias ll="ls -la"
alias ls="ls -hG"
alias tmux="tmux -2"
alias vim="mvim -v"
alias vimdiff="mvimdiff -v"

# Plugins
autoload compinit && compinit
autoload colors && colors
autoload -Uz vcs_info
source ~/.zsh-plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

## Compinstall
zstyle ':compinstall' filename "$HOME/.zshrc"
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh_cache
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' verbose yes
zstyle ':completion:*:commands' rehash 1
zstyle ':completion::(^approximate):*:functions' ignored-patterns '_*'
zstyle ':completion:*:*:vim:*:*files' ignored-patterns '*.o' '.pyc'

## VCS info
zstyle ':vcs_info:*' enable git hg
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr "%{$fg[green]%}✔%{$reset_color%}"
zstyle ':vcs_info:*' unstagedstr "%{$fg[red]%}✘%{$reset_color%}"
zstyle ':vcs_info:*' formats "%{$fg[magenta]%}(%s) %{$fg_bold[cyan]%} %b%{$reset_color%} %c %u"
zstyle ':vcs_info:*' actionformats "%s→%b (%c%u) %a"
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked git-st
# Hooks
function +vi-git-untracked() {
  # Show if untracked files are present in git
  local untracked

  untracked=${$(git ls-files --exclude-standard --others | head -n 1)}
  if [[ -n ${untracked} ]] ; then
    hook_com[unstaged]+=" %{$fg[yellow]%}✚%{$reset_color%}"
  fi
}
function +vi-git-st() {
  # Show difference between local and remote
  local ahead behind remote
  local -a gitstatus

  # Check for remote branch
  remote=${$(git rev-parse --verify ${hook_com[branch]}@{upstream} --symbolic-full-name --abbrev-ref 2> /dev/null)}
  if [[ -n ${remote} ]] ; then
    ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2> /dev/null | wc -l)
    (( $ahead )) && gitstatus+=( " %{$fg[green]%}↑${ahead// /}%{$reset_color%}" )
    behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} | wc -l)
    (( $behind )) && gitstatus+=( "%{$fg[red]%}↓${behind// /}%{$reset_color%}" )
    hook_com[branch]+="%{$reset_color%} %{$fg[cyan]%}:: ${remote}${(j: :)gitstatus}%{$fg[cyan]%}"
  fi
}

# Build prompt
build_prompt() {
  PROMPT="${vcs_info_msg_0_}
%{$fg[yellow]%}%m →%{$reset_color%} "
  RPROMPT="%{$fg[yellow]%}%~%{$reset_color%}"
}
