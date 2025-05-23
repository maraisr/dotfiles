#!/usr/bin/env fish

if test (uname) != Darwin
    exit
end

mkdir -p ~/.gnupg
test -f ~/.gnupg/gpg-agent.conf || touch ~/.gnupg/gpg-agent.conf

grep -q "pinentry-program" ~/.gnupg/gpg-agent.conf || echo "pinentry-program "(which pinentry-mac) >> ~/.gnupg/gpg-agent.conf

# ask password every 24hours only
grep -q "default-cache-ttl" ~/.gnupg/gpg-agent.conf || echo "default-cache-ttl 86400" >> ~/.gnupg/gpg-agent.conf
grep -q "max-cache-ttl" ~/.gnupg/gpg-agent.conf || echo "max-cache-ttl 86400" >> ~/.gnupg/gpg-agent.conf
