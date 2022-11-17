#!/usr/bin/env fish

if test (uname) != Darwin
    exit
end

mkdir -p ~/.ssh
test -f ~/.ssh/config || touch ~/.ssh/config

grep -q "UseKeychain yes" ~/.ssh/config || echo -e '\nHost *\n  UseKeychain yes\n' >> ~/.ssh/config
