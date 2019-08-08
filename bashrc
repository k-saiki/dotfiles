export TERM=xterm-256color
HISTSIZE=10000
HISTTIMEFORMAT='%Y/%m/%d %H:%M:%S '
HISTIGNORE=history:ls:ll:la:cd

# direnv
eval "$(direnv hook bash)"
