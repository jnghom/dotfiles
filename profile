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

# if [ -x "$HOME/scripts/ssh-add-all.sh" ]; then
#     bash $HOME/scripts/ssh-add-all.sh
# fi

if type hub &> /dev/null ; then
  eval "$(hub alias -s)"
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
if [ -d "$HOME/flutter/bin" ] ; then
    PATH="$HOME/flutter/bin:$PATH"
fi
. "$HOME/.cargo/env"

# [ ! -z "$LOCAL_GIT_NAME" ] && git config --global user.name $LOCAL_GIT_NAME
# [ ! -z "$LOCAL_GIT_EMAIL" ] && git config --global user.email $LOCAL_GIT_EMAIL
# [ ! -z "$LOCAL_SSL_CRT " ] && git config --global http.sslCAInfo $LOCAL_SSL_CRT
# git config --global core.editor $EDITOR
