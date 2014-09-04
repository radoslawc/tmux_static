#!/bin/bash
 
set -e
 
TMUX_VERSION=1.9a
 
mkdir -p $HOME/local $HOME/tmux_tmp
cd $HOME/tmux_tmp
 
wget -O tmux-${TMUX_VERSION}.tar.gz  "http://downloads.sourceforge.net/project/tmux/tmux/tmux-1.9/tmux-1.9a.tar.gz?r=http%3A%2F%2Ftmux.sourceforge.net%2F&ts=1409781305&use_mirror=skylink"
wget https://github.com/downloads/libevent/libevent/libevent-2.0.21-stable.tar.gz
wget ftp://ftp.gnu.org/gnu/ncurses/ncurses-5.9.tar.gz
 
if [ -f "/etc/redhat-release" ]; then 

sudo yum -y install glibc-static.x86_64 || su -c "yum -y install glibc-static.x86_64 "

fi

tar xvzf libevent-2.0.21-stable.tar.gz
cd libevent-2.0.21-stable
./configure --prefix=$HOME/local --disable-shared
make
make install
cd ..
 
tar xvzf ncurses-5.9.tar.gz
cd ncurses-5.9
./configure --without-ada --without-cxx --without-progs --without-manpages --disable-db-install --without-tests --with-default-terminfo-dir=/usr/share/terminfo --with-terminfo-dirs="/etc/terminfo:/lib/terminfo:/usr/share/terminfo" --prefix=$HOME/local
make
make install
cd ..
 
tar xvzf tmux-${TMUX_VERSION}.tar.gz
cd tmux-${TMUX_VERSION}
./configure --enable-static CFLAGS="-I$HOME/local/include -I$HOME/local/include/ncurses" LDFLAGS="-L$HOME/local/lib -L$HOME/local/include/ncurses -L$HOME/local/include" LIBEVENT_CFLAGS="-I$HOME/local/include" LIBEVENT_LIBS="-L$HOME/local/lib -levent"
make
cp tmux $HOME/local/bin
cd ..
 
rm -rf $HOME/tmux_tmp
 
echo "all done, have fun"

echo "you can find tmux in $HOME/local/bin"


