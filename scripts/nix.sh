#!/bin/bash

# Install Volta
curl https://get.volta.sh | bash

# Get Plug (Vim Plugin Manager)
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Make `Dev` directory
mkdir -p "$HOME/dev"
