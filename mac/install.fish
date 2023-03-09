#!/usr/bin/env fish

if test (uname) != Darwin
    exit
end

if command -qs brew
    set -Ua fish_user_paths /usr/local/sbin /opt/homebrew/bin
end

touch ~/.hushlogin

./mac/defaults.sh
