directory '/opt/plex'
directory '/opt/plex/config' do
  user ENV['SUDO_UID']
  group ENV['SUDO_GID']
end
directory '/opt/plex/transcode' do
  user ENV['SUDO_UID']
  group ENV['SUDO_GID']
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
    '/home/jmb/Videos/tv:/data/tvshows',
    '/home/jmb/Videos/movies:/data/movies'
  ]
end
