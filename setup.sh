#!/bin/sh

THISPATH=$(dirname $(readlink -f $0))

sudo apt install vim xclip ack-grep tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm > /dev/null 2>&1
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim --silent

ln -sf ${THISPATH}/vimrc ~/.vimrc
ln -sf ${THISPATH}/ackrc ~/.ackrc
ln -sf ${THISPATH}/tmux.conf ~/.tmux.conf
git config --global include.path ${THISPATH}/gitconfig

grep -qF 'source '"${THISPATH}"'/bashrc' ~/.bashrc || echo 'source '"${THISPATH}"'/bashrc' >> ~/.bashrc
