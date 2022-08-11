#!/usr/bin/env bash

set +e

# NOTE! Currently assumes apt

sudo -v

# Update
sudo apt update
sudo apt upgrade -y

# Install deps
sudo apt install -y \
    curl \
	wget \
	git-extras \
	git \
	openssl \
	fzf \
	jq \
	bat \
	watchman \
	fish \
	gnupg

# TODO: once codespaces uses Ubuntu 21.04, add this: zoxide yq