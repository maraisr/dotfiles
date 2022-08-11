#!/usr/bin/env fish

rm -rf ~/.vimrc
ln -s (pwd)/.vimrc ~

curl -sfLo ~/.vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +'PlugUpdate | PlugInstall --sync' +qa