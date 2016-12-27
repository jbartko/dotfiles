case node['platform_family']
when 'fedora'
  include_recipe 'yum::dnf_yum_compat'
  include_recipe 'bartko_wants::fedora_repos'
  distro_packages = ['nmap-ncat','vim-enhanced']
when 'debian'
  include_recipe 'apt'
  include_recipe 'bartko_wants::ubuntu_repos'
  distro_packages = ['netcat','vim']
end

package distro_packages + %w{
  atom
  atop
  git
  google-chrome-stable
  hipchat4
  htop
  ncdu
  nmap
  jq
  rsync
  strace
  tcpdump
  telnet
  tmux
  vim
}

include_recipe 'bartko_wants::awscli' if node['bartko_wants']['awscli']
include_recipe 'bartko_wants::docker' if node['bartko_wants']['docker']
include_recipe 'bartko_wants::plex' if node['bartko_wants']['plex']
