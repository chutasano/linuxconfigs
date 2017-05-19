all: vimrc ackrc

vimrc:
	ln -s ${CURDIR}/.vimrc ~/.vimrc

ackrc:
	ln -s ${CURDIR}/.ackrc ~/.ackrc
