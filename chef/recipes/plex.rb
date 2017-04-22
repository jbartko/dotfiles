require 'etc'

directory '/opt/plex'
directory '/opt/plex/config' do
  owner ENV['SUDO_UID'].to_i
  group ENV['SUDO_GID'].to_i
end
directory '/opt/plex/transcode' do
  owner ENV['SUDO_UID'].to_i
  group ENV['SUDO_GID'].to_i
end
directory "#{Etc.getpwuid(ENV['SUDO_UID'].to_i).dir}/Videos" do
  owner ENV['SUDO_UID'].to_i
  group ENV['SUDO_GID'].to_i
end
directory "#{Etc.getpwuid(ENV['SUDO_UID'].to_i).dir}/Videos/movies" do
  owner ENV['SUDO_UID'].to_i
  group ENV['SUDO_GID'].to_i
end
directory "#{Etc.getpwuid(ENV['SUDO_UID'].to_i).dir}/Videos/tv" do
  owner ENV['SUDO_UID'].to_i
  group ENV['SUDO_GID'].to_i
end

include_recipe 'bartko_wants::docker'

docker_image 'plexinc/pms-docker'

docker_container 'plex' do
  env [
    "PLEX_UID=#{ENV['SUDO_UID']}",
    "PLEX_GID=#{ENV['SUDO_GID']}",
    'TZ=America/Chicago',
    'VERSION=latest'
  ]
  kill_after 60
  network_mode 'host'
  repo 'plexinc/pms-docker'
  restart_policy 'always'
  volumes [
    '/opt/plex/config:/config',
    '/opt/plex/transcode:/transcode',
    "#{Etc.getpwuid(ENV['SUDO_UID'].to_i).dir}/Videos/tv:/data/tvshows",
    "#{Etc.getpwuid(ENV['SUDO_UID'].to_i).dir}/Videos/movies:/data/movies"
  ]
end
