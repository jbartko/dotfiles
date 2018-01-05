#!/bin/bash

# Drop filesystem cache
# https://www.virtualbox.org/ticket/14746
echo 3 > /proc/sys/vm/drop_caches

# Install git
(
    grep -q Fedora /etc/*release* 2>/dev/null && \
        (dnf makecache && dnf install -y git && dnf update -y vim*) || \
        echo is not fedora
) | tee -a bootstrap.log

(
    grep -q Ubuntu /etc/*release* 2>/dev/null && \
        (apt-get update && apt-get install -y git) || \
        echo is not ubuntu
) | tee -a bootstrap.log

# be not root, install freshshell
su vagrant -c '
  git clone https://github.com/freshshell/fresh ~/.fresh/source/freshshell/fresh
  ln -s .dotfiles/freshrc .freshrc
  ~/.fresh/source/freshshell/fresh/bin/fresh install
  grep -q "^source ~/.fresh/build/shell.sh$" ~/.bashrc || echo "source ~/.fresh/build/shell.sh" | tee -a ~/.bashrc
'

# be not root, install Chef, converge
su vagrant -c '
  source ~/.fresh/build/shell.sh
  chef-workstation-bootstrap -j ~/.dotfiles/chef/dna.json
'

# probably don't care
#
# # fc
# sudo dnf install @workstation-product-environment
# sudo systemctl set-default graphical.target
#
# # ubuntu
# sudo apt-get install ubuntu-desktop
