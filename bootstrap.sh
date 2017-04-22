#!/bin/bash

(grep -q Fedora /etc/*release* && (dnf makecache fast && dnf install -y git && dnf update -y vim*) || echo is not fedora) | tee -a whatami
(grep -q Ubuntu /etc/*release* && (apt-get update) || echo is not ubuntu) | tee -a whatami

whoami | tee -a whoami1
sudo -u vagrant -- whoami | tee -a whoami2

# be not root, freshshell
su - vagrant -c '
  git clone https://github.com/freshshell/fresh ~/.fresh/source/freshshell/fresh
  ln -s .dotfiles/freshrc .freshrc
  ~/.fresh/source/freshshell/fresh/bin/fresh install
  echo "source ~/.fresh/build/shell.sh" | tee -a ~/.bashrc
'

# be not root, Chef
su vagrant -c '
  source ~/.fresh/build/shell.sh
  chef-workstation-bootstrap -j ~/.dotfiles/chef/dna.json
'

# probably don't care
# systemctl set-default <name of target>.target
# # fc
# sudo dnf install @workstation-product-environment
# sudo systemctl set-default graphical.target
#
# # ubuntu
# sudo apt-get install ubuntu-desktop
