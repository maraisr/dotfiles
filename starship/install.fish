#!/usr/bin/env fish

if test (uname) != Darwin
    exit
end

ln -sf (pwd)/starship/starship.toml ~/.config/starship.toml
