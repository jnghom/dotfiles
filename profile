# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# custom

# export LANG=en_US.UTF-8
# export LC_ALL=en_US.UTF-8

if [ -x "$HOME/scripts/ssh-add-all.sh" ]; then
    bash $HOME/scripts/ssh-add-all.sh
fi

if type hub &> /dev/null ; then
  eval "$(hub alias -s)"
fi

if [ -d "$HOME/.cargo" ]; then
  export CARGO_BIN="$HOME/.cargo/bin"
  export PATH="$CARGO_BIN:$PATH"
fi

if type yarn &> /dev/null ; then
  export YARN_BIN="$HOME/.yarn/bin"
  export PATH="$YARN_BIN:$PATH"
fi

if [ -x "$HOME/.pyenv/bin/pyenv" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
fi


if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

if [ -d "/usr/local/go/bin" ]; then
  export GOROOT=/usr/local/go
  export GOPATH=$HOME/go
  export PATH=$GOPATH/bin:$PATH:$GOROOT/bin
fi

if [ -d "$HOME/usr/bin" ] ; then
    export PATH="$HOME/usr/bin:$PATH"
fi

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
