#!/usr/bin/env fish

if test (uname) != Darwin
    exit
end

ln -sf (pwd)/ghostty/config ~/.config/ghostty/config
