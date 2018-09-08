#!/bin/sh

THISPATH=$(dirname $(readlink -f $0))

sudo apt update

 # on WSL I found ack instead of ack-grep??
sudo apt install -y \
    vim \
    xclip \
    ack-grep \
    ack \
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
    xclip \
    zip

#ensures tl;dr gets set up
tldr

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm > /dev/null 2>&1
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim --silent

ln -sf ${THISPATH}/vimrc ~/.vimrc
ln -sf ${THISPATH}/ackrc ~/.ackrc
ln -sf ${THISPATH}/tmux.conf ~/.tmux.conf
git config --global include.path ${THISPATH}/gitconfig

grep -qF 'source '"${THISPATH}"'/bashrc' ~/.bashrc || echo 'source '"${THISPATH}"'/bashrc' >> ~/.bashrc
