#!/bin/bash

ln -s $(pwd)/tmux/.tmux.conf ~
ln -s $(pwd)/vim/.vimrc ~

cp -f $(pwd)/git/.gitconfig ~
cp -f $(pwd)/git/.gitignore-global ~
