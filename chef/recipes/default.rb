case node['platform_family']
when 'fedora'
  include_recipe 'yum::dnf_yum_compat'
  include_recipe 'bartko_wants::fedora_repos'
  distro_packages = ['nmap-ncat','vim-enhanced']
when 'debian'
  include_recipe 'apt'
  include_recipe 'bartko_wants::ubuntu_repos'
  distro_packages = ['atom','netcat','vim']
else
  distro_packages = []
end

package distro_packages + %w{
  atop
  git
  google-chrome-stable
  hipchat4
  htop
  jq
  ncdu
  nmap
  python-pip
  rsync
  strace
  tcpdump
  telnet
  tmux
}

include_recipe 'bartko_wants::awscli' if node['bartko_wants']['awscli']
include_recipe 'bartko_wants::docker' if node['bartko_wants']['docker']
include_recipe 'bartko_wants::plex' if node['bartko_wants']['plex']
