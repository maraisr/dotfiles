#!/usr/bin/env fish

curl -sfLo ~/.vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim -Es +'PlugUpdate | PlugInstall --sync' +qa
