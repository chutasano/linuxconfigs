#!/bin/sh

# NOTE: Contains overrides for setup.sh -- need to run AFTER setup.sh

THISPATH=$(dirname $(readlink -f $0))

sudo apt update

 # on WSL I found ack instead of ack-grep??
sudo apt install -y \
    ack 

grep -qF 'source '"${THISPATH}"'/wsl.bash' ~/.bashrc || echo 'source '"${THISPATH}"'/wsl.bash' >> ~/.bashrc
