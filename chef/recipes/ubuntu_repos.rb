apt_repository 'atlassian-artifactory' do
  components ['main']
  distribution node['lsb']['codename']
  key 'https://atlassian.artifactoryonline.com/atlassian/api/gpg/key/public'
  uri 'https://atlassian.artifactoryonline.com/atlassian/hipchat-apt-client'
end

apt_repository 'google-chrome' do
  arch 'amd64'
  components ['main']
  distribution 'stable'
  key 'https://dl.google.com/linux/linux_signing_key.pub'
  uri 'http://dl.google.com/linux/chrome/deb/'
end

apt_repository 'pasi-niemi-lastpass-cli' do
  uri 'ppa:pasi-niemi/lastpass-cli'
end if node['platform_version'] == '14.04'

apt_repository 'webupd8team-atom' do
  uri 'ppa:webupd8team/atom'
end

apt_repository 'wireshark-dev-stable' do
  uri 'ppa:wireshark-dev/stable'
end
