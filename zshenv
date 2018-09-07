[ -f $HOME/.localrc ] && source $HOME/.localrc
if [ ! -z $LOCAL_PROXY ]; then
  export HTTP_PROXY=$LOCAL_PROXY
  export HTTPS_PROXY=$LOCAL_PROXY
  export FTP_PROXY=$LOCAL_PROXY
  export SOCKS_PROXY=$LOCAL_PROXY
  export ALL_PROXY=$LOCAL_PROXY
  export http_proxy=$LOCAL_PROXY
  export https_proxy=$LOCAL_PROXY
  export ftp_proxy=$LOCAL_PROXY
  export socks_proxy=$LOCAL_PROXY
  export all_proxy=$LOCAL_PROXY
fi
if [ ! -z $LOCAL_AUTO_PROXY ]; then
  export AUTO_PROXY=$LOCAL_AUTO_PROXY
  export auto_proxy=$LOCAL_AUTO_PROXY
fi

if [ -x "$HOME/.pyenv/bin/pyenv" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

if type cargo > /dev/null ; then
  export CARGO_BIN="$HOME/.cargo/bin"
  export PATH="$CARGO_BIN:$PATH"
fi

if type yarn > /dev/null ; then
  export YARN_BIN="$HOME/.yarn/bin"
  export PATH="$YARN_BIN:$PATH"
fi

if [ -s "$NVM_DIR/nvm.sh" ]; then
  export NVM_DIR="$HOME/.nvm"
  \. "$NVM_DIR/nvm.sh"
fi

if [ -d "$HOME/usr/bin" ]; then
  export USER_BIN="$HOME/usr/bin"
  export PATH=$USER_BIN:$PATH
fi

export LANG=en_US.UTF-8
if type cargo > /dev/null ; then
  export EDITOR=nvim
  export VISUAL=nvim
fi

if [ -d "/usr/local/go/bin" ]; then
  export GOROOT=/usr/local/go
  # export PATH=$PATH:/usr/local/go/bin
  export GOPATH=$HOME/go
  export PATH=$GOPATH/bin:$PATH:$GOROOT/bin
fi

if type hub > /dev/null ; then
  eval "$(hub alias -s)"
fi
