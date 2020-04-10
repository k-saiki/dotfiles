# Environment
export LANG=ja_JP.UTF-8

# Prompt
## Enable color
autoload -Uz colors && colors
## Left prompt
PROMPT="${fg[cyan]}[%D{%Y-%m-%d %H:%M:%S}]${reset_color}" # Timestamp
PROMPT+="${fg[yellow]}%n${reset_color}@"                  # Username
PROMPT+="${fg[green]}%~${reset_color} "                   # Directory
PROMPT+=$'\n'
PROMPT+="%1(v|${fg[blue]}%1v${reset_color}|)"             # VCS branch
PROMPT+="%2(v|${fg[yellow]}%2v${reset_color}|)"           # VCS status
PROMPT+="%3(v|%${fg[red]}%3v${reset_color}|)"             # VCS error messages
PROMPT+="$ "
## Right prompt
RPROMPT=

# zsh options
setopt print_eight_bit
setopt no_beep
setopt no_flow_control
setopt interactive_comments
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt extended_glob
setopt hist_ignore_dups
setopt extended_history
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_verify
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_no_store
setopt hist_expand
setopt inc_append_history
setopt nonomatch

# Eanble add-zsh-hook
autoload -Uz add-zsh-hook

# Prepare to show VCS information on prompt
autoload -Uz vcs_info

# Export 3 type messages
#   $vcs_info_msg_0_: Normal
#   $vcs_info_msg_1_: Warning
#   $vcs_info_msg_2_: Error
zstyle ':vcs_info:*' max-exports 3
__show_vcs_info_precmd() {
  vcs_info
  psvar=()
  [[ -n $vcs_info_msg_0_ ]] && psvar[1]=$vcs_info_msg_0_
  [[ -n $vcs_info_msg_1_ ]] && psvar[2]=$vcs_info_msg_1_
  [[ -n $vcs_info_msg_2_ ]] && psvar[3]=$vcs_info_msg_2_
}
add-zsh-hook precmd __show_vcs_info_precmd

# vcs_info defaults
zstyle ':vcs_info:*' enbale git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' check-for-staged-changes true

# vcs_info for Git
readonly GIT_STAGED_SYMBOL='⇡'
readonly GIT_UNSTAGED_SYMBOL='⇣'
zstyle ':vcs_info:git:*' stagedstr ${GIT_STAGED_SYMBOL}
zstyle ':vcs_info:git:*' unstagedstr ${GIT_UNSTAGED_SYMBOL}
__define_git_symbol() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) != 'true' ]]; then
    return 1
  fi
  GIT_SYMBOL=''
  zstyle ':vcs_info:git:*' formats "${GIT_SYMBOL} %b" '%u%c'
  zstyle ':vcs_info:git:*' actionformats "${GIT_SYMBOL} %b" '%u%c %m' '<!%a>'
}
add-zsh-hook chpwd __define_git_symbol

# History
HISTFILE=${HOME}/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward

# Completion
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*:sudo:*' command-path $PATH
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

# Alias
alias cp='nocorrect cp'
alias mv='nocorrect mv'
alias rm='nocorrect rm'
alias mkdir='nocorrect mkdir'
alias sl='ls -FGh'
alias ls='ls -FGh'
alias la='ls -lah'
alias ll='ls -lh'
alias history-all='history -E 1'
alias diff='colordiff -u'
alias y2j='yq '\''.'\'''
alias j2y='yq -y '\''.'\'''
alias openssl-hash-cert='(){openssl x509 -noout -modulus -in $1 | md5}'
alias openssl-hash-key='(){openssl rsa -noout -modulus -in $1 | md5}'
alias openssl-hash-csr='(){openssl req -noout -modulus -in $1 | md5}'
alias openssl-show-cert='(){openssl x509 -text -noout -in $1}'
alias openssl-show-key='(){openssl rsa -text -noout -in $1}'
alias openssl-show-csr='(){openssl req -text -noout -in $1}'
alias brew='env PATH=${PATH//$(pyenv root)\/shims:/} brew'
## AWS
alias checkip='curl https://checkip.amazonaws.com'
alias aws-windows-2012-latest='aws ssm get-parameters --names /aws/service/ami-windows-latest/Windows_Server-2012-R2_RTM-Japanese-64Bit-Base'
alias aws-windows-2016-latest='aws ssm get-parameters --names /aws/service/ami-windows-latest/Windows_Server-2016-Japanese-Full-Base'
alias aws-windows-2019-latest='aws ssm get-parameters --names /aws/service/ami-windows-latest/Windows_Server-2019-Japanese-Full-Base'
alias aws-amazonlinux-latest='aws ssm get-parameters --names /aws/service/ami-amazon-linux-latest/amzn-ami-hvm-x86_64-gp2'
alias aws-amazonlinux2-latest='aws ssm get-parameters --names /aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2'
alias aws-ecr-login='(){aws ecr get-login-password | docker login --username AWS --password-stdin $1}'

# kubectl
source <(kubectl completion zsh)

# direnv
eval "$(direnv hook zsh)"

# anyenv
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

# Golang
eval "$(goenv init -)"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"

# AWS CLI
source /usr/local/share/zsh/site-functions/aws_zsh_completer.sh

# hub
eval "$(hub alias -s)"
