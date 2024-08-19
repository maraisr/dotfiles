#!/usr/bin/env fish

if test (uname) != Darwin
    curl -sS https://starship.rs/install.sh | sh
end

ln -sf (pwd)/starship/starship.toml ~/.config/starship.toml
