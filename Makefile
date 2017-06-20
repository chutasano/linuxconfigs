all: vimrc ackrc bashrc tmuxconf deps

vimrc:
	ln -s ${CURDIR}/vimrc ~/.vimrc

ackrc:
	ln -s ${CURDIR}/ackrc ~/.ackrc

bashrc:
	grep -qF 'source ${CURDIR}/bashrc' ~/.bashrc || echo 'source ${CURDIR}/bashrc' >> ~/.bashrc

tmuxconf:
	ln -s ${CURDIR}/tmux.conf ~/.tmux.conf

deps:
	chmod 744 deps.sh
