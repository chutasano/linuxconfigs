#!/bin/sh

# NOTE: Contains overrides for setup.sh -- need to run AFTER setup.sh

grep -qF 'export DOT_WSL=1' ~/.dotdefs || echo 'export DOT_WSL=1' >> ~/.dotdefs

THISPATH=$(dirname $(readlink -f $0))

