# Exports
export EDITOR="nvim"
export LESS=-R
export LC_ALL=en_US.UTF-8
export LC_LANG=en_US.UTF-8
export PATH=$PATH:$HOME/.local/bin
export GPG_TTY=$(tty)

## Homebrew
case `uname` in
  Darwin)
    export PATH="/usr/local/sbin":$PATH
  ;;
esac

## Golang
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin:$GOROOT/bin

## Java (for Bazel)
export JAVA_HOME=/usr/lib/jvm/default/

## TeX
case `uname` in
  Darwin)
    export PATH=$PATH:/usr/local/texlive/2019/bin/x86_64-darwin
  ;;
  Linux)
    export PATH=$PATH:/usr/local/texlive/2019/bin/x86_64-linux
  ;;
esac

# Aliases
alias grep="grep --color=always"
case `uname` in
  Darwin)
    alias ls="ls -hG"
  ;;
  Linux)
    alias ls="ls -h --color=auto --group-directories-first"
  ;;
esac
alias l="ls -l"
alias la="ls -a"
alias ll="ls -la"
alias tmux="tmux -2"
alias vim="nvim"
alias todo="git grep -nEI 'TODO\(kdungs\)' | sed 's/  */ /g'"
alias todos="git grep -nEI 'TODO' | sed 's/  */ /g'"
alias blaze="bazel"

# Pyenv
export PATH=$HOME/.pyenv/bin:$PATH
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# ZSH specific
## Functions
precmd() {
  vcs_info
  build_prompt
}

build_prompt() {
  # Requires Nerd fonts
  # https://github.com/ryanoasis/nerd-fonts
  sshp=""
  if [ -n "${SSH_CLIENT}" ] || [ -n "${SSH_TTY}" ]; then
    sshp="%{$fg[green]%}ﮈ%{$reset_color%} "
  fi
  PROMPT="${vcs_info_msg_0_}
${sshp}%{$fg[yellow]%}%m →%{$reset_color%} "
  if [ -v PYENV_VERSION ]; then
    PROMPT="%{$fg[blue]%} ${PYENV_VERSION}%{$reset_color%} ${PROMPT}"
  fi
  RPROMPT="%{$fg[yellow]%}%~%{$reset_color%}"
}

## History
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt SHARE_HISTORY

## Options
setopt AUTOCD
setopt CORRECT
setopt EXTENDED_GLOB
setopt HASH_LIST_ALL
setopt NOMATCH
setopt NO_BEEP

## Plugins
### Completion
autoload compinit && compinit
zstyle ':compinstall' filename "$HOME/.zshrc"
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh_cache
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' verbose yes
zstyle ':completion:*:commands' rehash 1
zstyle ':completion::(^approximate):*:functions' ignored-patterns '_*'
zstyle ':completion:*:*:vim:*:*files' ignored-patterns '*.o' '.pyc'

### Colors
autoload colors && colors

### VCS info
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git hg
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr "%{$fg[green]%}✔%{$reset_color%}"
zstyle ':vcs_info:*' unstagedstr "%{$fg[red]%}✘%{$reset_color%}"
zstyle ':vcs_info:*' formats "%{$fg[magenta]%}(%s) %{$fg_bold[cyan]%} %b%{$reset_color%} %c %u"
zstyle ':vcs_info:*' actionformats "%s→%b (%c%u) %a"
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked git-st
#### Hooks
function +vi-git-untracked() {  # Show if untracked files are present in git
  local untracked
  untracked=${$(git ls-files --exclude-standard --others | head -n 1)}
  if [[ -n ${untracked} ]] ; then
    hook_com[unstaged]+=" %{$fg[yellow]%}✚%{$reset_color%}"
  fi
}
function +vi-git-st() {  # Show difference between local and remote
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

### Syntax highlighting
source $HOME/.zsh-plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

### FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
