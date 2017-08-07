all: vimrc ackrc bashrc tmuxconf deps

vimrc:
	ln -sf ${CURDIR}/vimrc ~/.vimrc

ackrc:
	ln -sf ${CURDIR}/ackrc ~/.ackrc

bashrc:
	grep -qF 'source ${CURDIR}/bashrc' ~/.bashrc || echo 'source ${CURDIR}/bashrc' >> ~/.bashrc

gitconfig:
	git config --global include.path ${CURDIR}/gitconfig

tmuxconf:
	ln -sf ${CURDIR}/tmux.conf ~/.tmux.conf

deps:
	chmod 744 deps.sh
