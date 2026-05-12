#!/usr/bin/env fish
source ./script/utils.fish

grep -q '^auth.*pam_tid.so' /etc/pam.d/sudo_local 2>/dev/null; and exit 0
test -f /etc/pam.d/sudo_local.template; or exit 0

assume_sudo

sudo cp /etc/pam.d/sudo_local.template /etc/pam.d/sudo_local

# uncomment a leading `#` on any existing `auth ... pam_tid.so` line
sudo sed -i '' 's/^#[[:space:]]*\(auth.*pam_tid.so\)/\1/' /etc/pam.d/sudo_local

# if the template didn't include one, append it
grep -q '^auth.*pam_tid.so' /etc/pam.d/sudo_local
  or echo 'auth sufficient pam_tid.so' | sudo tee -a /etc/pam.d/sudo_local >/dev/null

success "Touch ID for sudo enabled"
