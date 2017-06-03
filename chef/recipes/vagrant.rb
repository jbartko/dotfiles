
# It looks like the vagrant cookbook fetches SHA-256 checksums dynamically from
#  https://releases.hashicorp.com/vagrant/VERS/vagrant_VERS_SHA256SUMS?direct
# checksums = {
#   '1.9.4' => {
#     'deb' => '25cb7803b52db459750ff7f99889f42be789746e9cdbd951af13ba72e2e86063',
#     'rpm' => '3b6da60b65d46cde2372361c0441bc865b014f37fb24eaf6d92271c34587a34e'
#   }
# }

# case node['platform_family']
# when 'fedora', 'rhel'
#   node.default['vagrant']['version'] = '1.9.5'
#   node.default['vagrant']['url'] = 'https://releases.hashicorp.com/vagrant/1.9.5/vagrant_1.9.5_x86_64.rpm'
#   # node.default['vagrant']['checksum'] = '3b6da60b65d46cde2372361c0441bc865b014f37fb24eaf6d92271c34587a34e'
#   node.default['vagrant']['checksum'] = '76e2598eb0f9b80d7d8b1be42feeda12275cfa4c68e4e318cf0715543245f98d'
# when 'debian'
#   node.default['vagrant']['version'] = '1.9.4'
#   node.default['vagrant']['url'] = 'https://releases.hashicorp.com/vagrant/1.9.5/vagrant_1.9.5_x86_64.deb'
#   node.default['vagrant']['checksum'] = '25cb7803b52db459750ff7f99889f42be789746e9cdbd951af13ba72e2e86063'
# end

node.default['vagrant']['version'] = '1.9.5'
include_recipe 'vagrant'
