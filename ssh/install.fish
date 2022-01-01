#!/usr/bin/env fish
test -f ~/.ssh/config || touch ~/.ssh/config

switch (uname)
case Darwin
	grep -q "UseKeychain yes" ~/.ssh/config || echo -e '\nHost *\n  UseKeychain yes\n' >> ~/.ssh/config
end