if node['platform_family'] == 'fedora' && node['platform_version'].to_i == 25
  package 'docker'

  service 'docker' do
    action [:enable, :start]
  end
else
  docker_service 'default' do
    action [:create, :start]
  end
end
