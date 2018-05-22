#!/bin/bash

sudo add-apt-repository -y ppa:pi-rho/dev
sudo apt-get update -y
sudo apt install tmux-next -y
sudo ln -f /usr/bin/tmux-next /usr/bin/tmux

