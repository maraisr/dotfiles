#!/usr/bin/env bash

set +e

# NOTE! Currently assumes apt

sudo -v

# Update
apt update
apt upgrade -y

# Install deps
apt install -y \
    curl \
	wget \
	git-delta \
	git \
	openssl \
	fzf \
	jq \
	yq \
	bat \
	watchman \
	fish \
	gnupg \
	zoxide