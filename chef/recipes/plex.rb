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

include_recipe 'bartko_wants::docker'

docker_image 'linuxserver/plex'

docker_container 'plex' do
  env [
    "PGID=#{ENV['SUDO_UID']}",
    "PUID=#{ENV['SUDO_GID']}",
    'TZ=America/Chicago',
    'VERSION=latest'
  ]
  kill_after 60
  network_mode 'host'
  repo 'linuxserver/plex'
  restart_policy 'always'
  volumes [
    '/opt/plex/config:/config',
    '/opt/plex/transcode:/transcode',
    "#{Etc.getpwuid(ENV['SUDO_UID'].to_i).dir}/Videos/tv:/data/tvshows",
    "#{Etc.getpwuid(ENV['SUDO_UID'].to_i).dir}/Videos/movies:/data/movies"
  ]
end
