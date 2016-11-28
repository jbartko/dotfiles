directory '/opt/plex'
directory '/opt/plex/config' do
  user 1000
  group 1000
end
directory '/opt/plex/transcode' do
  user 1000
  group 1000
end

include_recipe 'bartko_wants::docker'

docker_image 'linuxserver/plex'

docker_container 'plex' do
  env [
    'PGID=1000',
    'PUID=1000',
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
