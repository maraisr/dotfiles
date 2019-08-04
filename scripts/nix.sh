#!/bin/bash

# Install Volta
curl https://get.volta.sh | bash

# Get Plug (Vim Plugin Manager)
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Download my fonts
declare -a fonts=(
        "https://raw.githubusercontent.com/powerline/fonts/master/FiraMono/FuraMono-Regular%20Powerline.otf"
        "https://raw.githubusercontent.com/tonsky/FiraCode/master/distr/otf/FiraCode-Retina.otf"
    )

for fontUrl in "${fonts[@]}"
do
    fontName=$(basename -- "${fontUrl}")
    
    case $(uname -s) in
        Darwin*) curl -fLo ${HOME}/Library/Fonts/${fontName} --create-dirs ${fontUrl}
    esac
done

# Pip things
pip install boto boto3 jinja2

# Make `Sites` directory
mkdir -p "$HOME/Sites"