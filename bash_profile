[[ -s ~/.bashrc ]] && source ~/.bashrc

export PATH="/usr/local/sbin:$PATH"

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

source /usr/local/etc/bash_completion
source /usr/local/etc/bash_completion.d/git-completion.bash
source /usr/local/etc/bash_completion.d/git-prompt.sh

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUPSTREAM=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWSTASHSTATE=1
CUSTOM_PS1='[\[\033[1;32m\]\u\[\033[00m\]@\[\033[1;34m\]\w\[\033[00m\]](\D{%Y/%m/%d} \t)\n\[\033[1;31m\]$(__git_ps1)\[\033[00m\]\$ '
PS1=${CUSTOM_PS1}

# Alias
alias sl='ls -FGh'
alias ls='ls -FGh'
alias la='ls -lah'
alias ll='ls -lh'
alias diff='colordiff -u'
alias y2j='yq '\''.'\'''
alias j2y='yq -y '\''.'\'''
alias checkip='curl https://checkip.amazonaws.com'

alias aws-windows-2012-latest='aws ssm get-parameters --names /aws/service/ami-windows-latest/Windows_Server-2012-R2_RTM-Japanese-64Bit-Base'
alias aws-windows-2016-latest='aws ssm get-parameters --names /aws/service/ami-windows-latest/Windows_Server-2016-Japanese-Full-Base'
alias aws-windows-2019-latest='aws ssm get-parameters --names /aws/service/ami-windows-latest/Windows_Server-2019-Japanese-Full-Base'
alias aws-amazonlinux-latest='aws ssm get-parameters --names /aws/service/ami-amazon-linux-latest/amzn-ami-hvm-x86_64-gp2'
alias aws-amazonlinux2-latest='aws ssm get-parameters --names /aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2'

# anyenv
# https://github.com/riywo/anyenv
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

# goenv
eval "$(goenv init -)"
export PATH="$GOPATH/bin:$PATH"

# aws cli
complete -C '/usr/local/bin/aws_completer' aws

# hub
eval "$(hub alias -s)"

export PATH="$HOME/.poetry/bin:$PATH"
