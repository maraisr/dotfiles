#!/usr/bin/env bash

set +e

sudo -v

# Install deps
sudo apt install -y \
	git-lfs \
	git-extras \
	fish \
	vim \
	ripgrep \
    #zoxide
