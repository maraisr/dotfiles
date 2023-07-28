#!/usr/bin/env fish

cp -f (pwd)/.gitconfig ~

switch (uname)
case Darwin
	git config --global credential.helper osxkeychain
case '*'
	git config --global credential.helper cache
end

if command -qs delta
	git config --global core.pager delta
	git config --global interactive.diffFilter 'delta --color-only'
	git config --global delta.syntax-theme GitHub
	git config --global delta.line-numbers true
	git config --global delta.decorations true
end

git lfs install
