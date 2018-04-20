[ -f $HOME/.localrc ] && source $HOME/.localrc
if [ ! -z $LOCAL_PROXY ]; then
  echo local proxy $LOCAL_PROXY
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
  echo local auto proxy $LOCAL_AUTO_PROXY
  export AUTO_PROXY=$LOCAL_AUTO_PROXY
  export auto_proxy=$LOCAL_AUTO_PROXY
fi

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  # eval "$(pyenv virtualenv-init -)"
fi

export PATH="$HOME/.cargo/bin:$PATH"
