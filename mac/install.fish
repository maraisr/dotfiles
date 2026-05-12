#!/usr/bin/env fish
source ./script/utils.fish

if test (uname) != Darwin
    exit
end

if command -qs brew
    set -Ua fish_user_paths /usr/local/sbin /opt/homebrew/bin
end


touch ~/.hushlogin

./mac/touchid.fish
./mac/timemachine.fish

assume_sudo
./mac/defaults.sh
