case node['platform_family']
when 'fedora', 'rhel'
  node.default['vagrant']['version'] = '1.9.4'
  node.default['vagrant']['url'] = 'https://releases.hashicorp.com/vagrant/1.9.4/vagrant_1.9.4_x86_64.rpm'
  node.default['vagrant']['checksum'] = '3b6da60b65d46cde2372361c0441bc865b014f37fb24eaf6d92271c34587a34e'
when 'debian'
  node.default['vagrant']['version'] = '1.9.4'
  node.default['vagrant']['url'] = 'https://releases.hashicorp.com/vagrant/1.9.4/vagrant_1.9.4_x86_64.deb'
  node.default['vagrant']['checksum'] = '25cb7803b52db459750ff7f99889f42be789746e9cdbd951af13ba72e2e86063'
end

include_recipe 'vagrant'
