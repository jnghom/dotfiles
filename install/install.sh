mkdir -p $HOME/tmp
mkdir -p $USER_INSTALL
mkdir -p $USER_SRC
mkdir -p $USER_BIN

gh_download() {
  if [ $# -ne 2 ]; then
    echo 'usage: gh_download <address> <install-name>'
    return 1
  fi
  if [ -e $USER_SRC/$2 ]; then
    echo $USER_SRC/$2 already exists
    return 1
  fi
  git clone $1 $USER_SRC/$2
}

if git clone https://github.com/ranger/ranger.git $USER_SRC/ranger; then
  echo "ranger successfully downloaded"
  cd $USER_SRC/ranger && python setup.py install --optimize=1 --record=install_log.txt
  cd -
else
  echo "ranger download failed"
fi

if git clone https://github.com/ggreer/the_silver_searcher.git $USER_SRC/ag; then
  echo "ag successfully downloaded"
  mkdir -p $USER_INSTALL/ag
  cd $USER_SRC/ag
  ./build.sh && ./configure --prefix=$USER_INSTALL/ag && make && make install
  ln -s $USER_INSTALL/ag/bin/ag $USER_BIN/ag
  cd -
else
  echo "ag download failed"
fi

if git clone https://github.com/clvv/fasd.git $USER_SRC/fasd; then
  echo "fasd successfully downloaded"
  cd $USER_SRC/fasd
  mkdir -p $USER_INSTALL/fasd
  PREFIX=$USER_INSTALL/fasd make install
  ln -s $USER_INSTALL/fasd/bin/fasd $USER_BIN/fasd
  eval "$(fasd --init auto)"
  cd -
else
  echo "fasd download failed"
fi

if git clone https://github.com/facebook/PathPicker.git $USER_SRC/fpp; then
  ln -s $USER_SRC/fpp/fpp $USER_BIN/fpp
fi

# https://github.com/aykamko/tag

# ls++, not work
if git clone git://github.com/trapd00r/ls--.git $USER_SRC/ls--; then
  cpan Term::ExtendedColor
  cd $USER_SRC/ls--
  perl Makefile.PL
  # make && make DESTDIR=$USER_INSTALL/ls-- install
  make && su -c 'make install'
  cd -
fi


# glances
# pip install glances

# direnv
# https://github.com/direnv/direnv/releases
if git clone https://github.com/direnv/direnv $USER_SRC/direnv; then
  cd $USER_SRC/direnv
  make && make DESTDIR=$USER_INSTALL/direnv install
  cd -
fi

# lnav
if wget -L https://github.com/tstack/lnav/releases/download/v0.8.2/lnav-0.8.2-linux-64bit.zip -P $USER_SRC/lnav; then
  unzip $USER_SRC/lnav/lnav-0.8.2-linux-64bit.zip -d $USER_INSTALL/lnav
  ln -s $USER_INSTALL/lnav $USER_BIN/lnav
fi

# ncdu
if wget -L https://dev.yorhel.nl/download/ncdu-1.12.tar.gz -P $HOME/tmp; then
  mkdir -p $USER_SRC/ncdu
  tar xvzf $HOME/tmp/ncdu-1.12.tar.gz -C $USER_SRC/ncdu
  cd $USER_SRC/ncdu/ncdu-1.12
  ./configure --prefix=$USER_INSTALL/ncdu
  make && make install
  ln -s $USER_INSTALL/tmux/bin/tmux $USER_BIN/ncdu
  cd -
fi

# bd
if wget --no-check-certificate -O $USER_BIN/bd https://raw.github.com/vigneshwaranr/bd/master/bd; then
  chmod +x $USER_BIN/bd
fi

# tig
if git clone https://github.com/jonas/tig.git $USER_SRC/tig; then
  cd $USER_SRC/tig
  make prefix=$USER_INSTALL/tig
  make install prefix=$USER_INSTALL/tig
  ln -s $USER_INSTALL/tig/bin/tig $USER_BIN/tig
  cd -
fi

# tmux
# if curl -L https://github.com/tmux/tmux/releases/download/2.6/tmux-2.6.tar.gz -o $USER_SRC/tmux; then
if wget -L https://github.com/tmux/tmux/releases/download/2.6/tmux-2.6.tar.gz -P $HOME/tmp; then
  mkdir -p $USER_SRC/tmux
  tar xvzf $HOME/tmp/tmux-2.6.tar.gz -C $USER_SRC/tmux
  cd $USER_SRC/tmux/tmux-2.6
  ./configure --prefix=$USER_INSTALL/tmux
  make && make install
  ln -s $USER_INSTALL/tmux/bin/tmux $USER_BIN/tmux
  cd -
fi

# nvim
if wget -L https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage -P $USER_INSTALL/nvim; then
  ln -s $USER_INSTALL/nvim/nvim.appimage $USER_BIN/nvim
fi

# solarized dircolors
if git clone https://github.com/seebi/dircolors-solarized.git $USER_SRC/dircolors-solarized; then
  cp -p $USER_SRC/dircolors-solarized/dircolors.256dark $HOME/.colors
fi
