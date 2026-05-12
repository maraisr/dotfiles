#!/usr/bin/env fish
source ./script/utils.fish

set -l encoded_pass (\
  op read --account TN3WPOEQTVANPMMIMOXOMXNNDM "op://Private/UNAS/password"\
  | string escape --style=url)
or begin
  warn "failed to read TimeMachine password from 1Password"
  exit 0
end

assume_sudo
sudo tmutil setdestination "smb://marais:$encoded_pass@nas.rossouw.world/TimeMachine"
  or warn "failed to set Time Machine destination"

sudo tmutil enable
  and success "Time Machine enabled, hourly auto-backup"
  or warn "failed to enable Time Machine"
