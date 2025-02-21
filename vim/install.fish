#!/usr/bin/env fish

# TODO: Vim plug install, just hangs in a codespace? Is there a no tty option?
if test (uname) != Darwin
    exit
end

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim +'PlugUpdate | PlugInstall' +qall
