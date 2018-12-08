[[ -s ~/.bashrc ]] && source ~/.bashrc

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

source /usr/local/etc/bash_completion.d/git-completion.bash
source /usr/local/etc/bash_completion.d/git-prompt.sh

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUPSTREAM=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWSTASHSTATE=1
export PS1='[\[\033[1;32m\]\u\[\033[00m\]@\[\033[1;34m\]\w\[\033[00m\]](\D{%Y/%m/%d} \t)\n\[\033[1;31m\]$(__git_ps1)\[\033[00m\]\$ '

# Alias
alias sl='ls -FGh'
alias ls='ls -FGh'
alias la='ls -lah'
alias ll='ls -lh'
alias rm='rmtrash'
alias diff='colordiff -u'

# anyenv
# https://github.com/riywo/anyenv
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

# golang
export GOPATH=$HOME/develop/go
export PATH=$PATH:$GOPATH/bin

# aws cli
complete -C '/usr/local/bin/aws_completer' aws

# hub
eval "$(hub alias -s)"
