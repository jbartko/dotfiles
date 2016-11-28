case node['platform_family']
when 'fedora'
  include_recipe 'yum::dnf_yum_compat'
  include_recipe 'bartko_wants::fedora_repos'
end

package %w{
  atom
  atop
  git
  google-chrome-stable
  hipchat4
  htop
  nc
  ncdu
  nmap
  jq
  rsync
  strace
  tcpdump
  telnet
  tmux
  vim-enhanced
}

include_recipe 'bartko_wants::docker' if node['bartko_wants']['docker']
include_recipe 'bartko_wants::plex' if node['bartko_wants']['plex']
