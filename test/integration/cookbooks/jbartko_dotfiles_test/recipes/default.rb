# workaround for https://github.com/rosstimson/chef-terraform/issues/29
package 'bzip2' do
  action :nothing
end.run_action(:install)

include_recipe 'git'
include_recipe 'chefdk'

bash 'freshen dotfiles' do
  code <<-EOH
    FRESH_LOCAL_SOURCE=https://github.com/jbartko/dotfiles.git bash -c "`curl -sL get.freshshell.com`"
    echo "source ~/.fresh/build/shell.sh" | tee -a ~/.bashrc
    source ~/.bashrc
    EOH
  live_stream true
  not_if { ::File.exist?("#{ENV['HOME']}/.freshrc") }
end
