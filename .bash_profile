[[ -s ~/.bashrc ]] && source ~/.bashrc

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

source $HOME/.git-completion.bash
source $HOME/.git-prompt.sh

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUPSTREAM=1
GIT_PS1_SHOWUNTRACKEDFILES=
GIT_PS1_SHOWSTASHSTATE=1
export PS1='[\[\033[1;32m\]\u\[\033[00m\]@\[\033[1;34m\]\w\[\033[00m\]]\[\033[1;31m\]$(__git_ps1)\[\033[00m\] \$ '

# Alias
alias ls='ls -FhG'
alias la='ls -lah'
alias ll='ls -lh'

# anyenv
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

# golang
export GOPATH=$HOME/develop/go
export PATH=$PATH:$GOPATH/bin

# aws cli
complete -C '/usr/local/bin/aws_completer' aws
