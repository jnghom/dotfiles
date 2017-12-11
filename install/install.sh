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

https://github.com/aykamko/tag

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
# http://lnav.org/downloads/

# ncdu

# bd
wget --no-check-certificate -O $USER_BIN/bd https://raw.github.com/vigneshwaranr/bd/master/bd
chmod +x $USER_BIN/bd
