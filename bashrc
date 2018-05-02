export TERM=xterm-256color
export HISTSIZE=10000
HISTIGNORE=history:ls:ll:la:cd

### Virtualenvwrapper
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
  export WORKON_HOME=$HOME/.virtualenvs
  source /usr/local/bin/virtualenvwrapper.sh
fi

# direnv
eval "$(direnv hook bash)"
