[ -f $HOME/.localrc ] && source $HOME/.localrc

if [ -x "$HOME/.pyenv/bin/pyenv" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  # eval "$(pyenv init -)"
  # eval "$(pyenv virtualenv-init -)"
fi

if [ -d "$HOME/.cargo" ]; then
  export CARGO_BIN="$HOME/.cargo/bin"
  export PATH="$CARGO_BIN:$PATH"
fi

if type yarn &> /dev/null ; then
  export YARN_BIN="$HOME/.yarn/bin"
  export PATH="$YARN_BIN:$PATH"
fi

# if [ -d "$HOME/usr/bin" ]; then
#   export USER_BIN="$HOME/usr/bin"
#   export PATH=$USER_BIN:$PATH
# fi

export LANG=en_US.UTF-8
if type nvim &> /dev/null ; then
  export EDITOR=nvim
  export VISUAL=nvim
fi

# if [ -d "/usr/local/go/bin" ]; then
#   export GOROOT=/usr/local/go
#   export GOPATH=$HOME/go
#   export PATH=$GOPATH/bin:$PATH:$GOROOT/bin
# fi

# if type hub &> /dev/null ; then
#   eval "$(hub alias -s)"
# fi

if [ -d "/usr/local/go/bin" ]; then
  export GOROOT=/usr/local/go
  export GOPATH=$HOME/go
  export PATH=$GOPATH/bin:$PATH:$GOROOT/bin
fi

export PATH=$PATH:$HOME/.pulumi/bin
export PATH=$PATH:$HOME/usr/flutter/bin

if [ -d "$HOME/usr/bin" ]; then
  export USER_BIN="$HOME/usr/bin"
  export PATH=$USER_BIN:$PATH
fi

export PATH=$HOME/.local/bin:$PATH
