case node['platform_family']
when 'fedora'
  include_recipe 'yum::dnf_yum_compat'
  include_recipe 'bartko_wants::fedora_repos'
  distro_packages = %w{
    gitflow
    NetworkManager-openconnect
    nmap-ncat
    vim-enhanced
  }
  if node['platform_version'].to_i >= 25
    distro_packages += ['NetworkManager-openconnect-gnome']
  end
when 'debian'
  include_recipe 'apt'
  include_recipe 'bartko_wants::ubuntu_repos'
  distro_packages = %w{
    atom
    git-flow
    netcat
    network-manager-openconnect-gnome
    vim
  }
else
  distro_packages = []
end

(distro_packages + %w{
  atop
  bash-completion
  firefox
  git
  google-chrome-stable
  hipchat4
  htop
  jq
  lastpass-cli
  lsof
  ncdu
  nmap
  python-openstackclient
  python-pip
  remmina
  rsync
  strace
  sysstat
  tcpdump
  telnet
  tmux
  wireshark
}).sort.each do |pkg|
  package pkg
end

include_recipe 'bartko_wants::awscli' if node['bartko_wants']['awscli']
include_recipe 'bartko_wants::docker' if node['bartko_wants']['docker']
include_recipe 'bartko_wants::plex' if node['bartko_wants']['plex']
