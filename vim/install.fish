#!/usr/bin/env fish

ln -s (pwd)/.vimrc ~

curl -sfLo ~/.vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +'PlugUpdate | PlugInstall --sync' +qa