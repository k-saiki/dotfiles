# Environment
export LANG=ja_JP.UTF-8

# zsh options
# see http://zsh.sourceforge.net/Doc/Release/Options.html
setopt auto_cd
setopt auto_menu
setopt auto_param_keys
setopt auto_pushd
setopt complete_in_word
setopt extended_glob
setopt extended_history
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_verify
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_no_store
setopt hist_expand
setopt inc_append_history
setopt share_history
setopt interactive_comments
setopt nonomatch
setopt no_beep
setopt no_flow_control
setopt print_eight_bit
setopt pushd_ignore_dups

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
HISTSIZE=100000
SAVEHIST=1000000
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward

# Completion
if type brew &>/dev/null; then
  HOMEBREW_PREFIX=$(brew --prefix)
  source ${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  source ${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  FPATH=${HOMEBREW_PREFIX}/share/zsh-completions:$FPATH
  autoload -Uz compinit && compinit
fi

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
alias jq-paths='jq -c paths'
alias y2j='yq read --prettyPrint --tojson'
alias j2y='yq read --prettyPrint'

## AWS
alias checkip='curl https://checkip.amazonaws.com'
alias aws-windows-2012-latest='aws ssm get-parameters --names /aws/service/ami-windows-latest/Windows_Server-2012-R2_RTM-Japanese-64Bit-Base'
alias aws-windows-2016-latest='aws ssm get-parameters --names /aws/service/ami-windows-latest/Windows_Server-2016-Japanese-Full-Base'
alias aws-windows-2019-latest='aws ssm get-parameters --names /aws/service/ami-windows-latest/Windows_Server-2019-Japanese-Full-Base'
alias aws-amazonlinux-latest='aws ssm get-parameters --names /aws/service/ami-amazon-linux-latest/amzn-ami-hvm-x86_64-gp2'
alias aws-amazonlinux2-latest='aws ssm get-parameters --names /aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2'

# function
aws-ecr-login() {
  account_id=$(aws sts get-caller-identity | jq -r .Account)
  aws ecr get-login-password | docker login --username AWS --password-stdin ${account_id}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com
}

# Homebrew
export PATH="/usr/local/sbin:$PATH"

# hub
eval "$(hub alias -s)"

# asdf
source $(brew --prefix asdf)/asdf.sh

# direnv
eval "$(direnv hook zsh)"

# kubectl
source <(kubectl completion zsh)
alias k=kubectl
complete -o default -F __start_kubectl k
