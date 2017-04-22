# Repos

if os[:family] == 'fedora'
  describe yum do
    its('atlassian-artifactory') { should exist }
    its('atlassian-artifactory') { should be_enabled }
    its('google-chrome') { should exist }
    its('google-chrome') { should be_enabled }
  end
elsif os[:family] == 'debian'
  describe apt('https://atlassian.artifactoryonline.com/atlassian/hipchat-apt-client') do
    it { should exist }
    it { should be_enabled }
  end
  describe apt('ppa:webupd8team/atom') do
    it { should exist }
    it { should be_enabled }
  end

  describe apt('http://dl.google.com/linux/chrome/deb/') do
    it { should exist }
    it { should be_enabled }
  end
end



# Packages

%w{
  atom
  atop
  chefdk
  git
  google-chrome-stable
  hipchat4
  htop
  jq
  ncdu
  nmap
  python-pip
  rsync
  strace
  tcpdump
  telnet
  tmux
}.each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

if os[:family] == 'fedora'
  ['nmap-ncat','vim-enhanced'].each do |pkg|
    describe package(pkg) do
      it { should be_installed }
    end
  end
elsif os[:family] == 'debian'
  ['netcat','vim'].each do |pkg|
    describe package(pkg) do
      it { should be_installed }
    end
  end
end

describe pip('awscli') do
  it { should be_installed }
end

describe package('docker-engine') do
  it { should be_installed }
end



# Services

describe service('docker') do
  it { should be_running }
  it { should be_enabled }
end



# Containers

# describe docker_image('linuxserver/plex:latest') do
#   it { should exist }
# end

describe bash('docker images') do
  its('stdout') { should match /plexinc\/pms-docker\s+latest/ }
  its('stderr') { should eq '' }
  its('exit_status') { should eq 0 }
end

describe bash("docker inspect -f '{{ .State.Status }}' plex") do
  its('stdout') { should match /^running$/ }
  its('stderr') { should eq '' }
  its('exit_status') { should eq 0 }
end
