#!/usr/bin/env bash

set +e

sudo -v

sudo apt update

# Install deps
sudo apt install -y \
	git-extras \
	fish \
	vim \
	ripgrep \
    #zoxide
