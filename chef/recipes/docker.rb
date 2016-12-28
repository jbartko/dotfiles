if node['platform_family'] == 'fedora' && node['platform_version'].to_i == 25
  docker_installation_package 'default' do
    package_name 'docker'
    version '1.12.5'
    action :create
  end
else
  docker_service 'default' do
    action [:create, :start]
  end
end
