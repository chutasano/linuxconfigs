#!/bin/sh

THISPATH=$(dirname $(readlink -f $0))

sudo add-apt-repository -y ppa:jonathonf/vim
sudo apt update

 # on WSL I found ack instead of ack-grep??
sudo apt install -y \
    vim \
    xclip \
    ack-grep \
    tmux \
    curl \
    bear \
    tldr \
    xdg-utils \
    build-essential \
    cmake \
    clang \
    python python-dev \
    python3 python3-dev \
    zip \
    zathura

#ensures tl;dr gets set up
tldr --update

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm > /dev/null 2>&1
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim --silent

ln -sf ${THISPATH}/vimrc ~/.vimrc
ln -sf ${THISPATH}/ackrc ~/.ackrc
ln -sf ${THISPATH}/tmux.conf ~/.tmux.conf
git config --global include.path ${THISPATH}/gitconfig

touch ~/.dotdefs
grep -qF 'source '"${HOME}"'/.dotdefs' ~/.bashrc || echo 'source '"${HOME}"'/.dotdefs' >> ~/.bashrc

grep -qF 'source '"${THISPATH}"'/bashrc' ~/.bashrc || echo 'source '"${THISPATH}"'/bashrc' >> ~/.bashrc
grep -qF 'source '"${THISPATH}"'/bash_aliases' ~/.bashrc || echo 'source '"${THISPATH}"'/bash_aliases' >> ~/.bashrc

# for BASH_ENV
touch ~/.dotaliases
grep -qF 'source '"${HOME}"'/.dotdefs' ~/.dotaliases || echo 'source '"${HOME}"'/.dotdefs' >> ~/.dotaliases
grep -qF 'source '"${THISPATH}"'/bash_aliases' ~/.dotaliases || echo 'source '"${THISPATH}"'/bash_aliases' >> ~/.dotaliases
