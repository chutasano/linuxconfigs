all: vimrc ackrc bashrc deps

vimrc:
	ln -s ${CURDIR}/vimrc ~/.vimrc

ackrc:
	ln -s ${CURDIR}/ackrc ~/.ackrc

bashrc:
	grep -qF 'source ${CURDIR}/bashrc' ~/.bashrc || echo 'source ${CURDIR}/bashrc' >> ~/.bashrc

deps:
	chmod 744 deps.sh
