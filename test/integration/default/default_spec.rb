control 'Repositories' do
  title 'Ensure third-party repositories are added'

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

    describe apt('http://dl.google.com/linux/chrome/deb/') do
      it { should exist }
      it { should be_enabled }
    end

    describe apt('ppa:pasi-niemi/lastpass-cli') do
      it { should exist }
      it { should be_enabled }
    end if os[:release].start_with?('14')

    describe apt('ppa:webupd8team/atom') do
      it { should exist }
      it { should be_enabled }
    end

    describe apt('ppa:wireshark-dev/stable') do
      it { should exist }
      it { should be_enabled }
    end
  end
end

control 'Packages' do
  title 'Ensure packages are installed'

  %w{
    atom
    atop
    bash-completion
    chefdk
    firefox
    git
    google-chrome-stable
    hipchat4
    htop
    jq
    lastpass-cli
    lsof
    ncdu
    nmap
    remmina
    rsync
    strace
    sysstat
    tcpdump
    telnet
    tmux
    wireshark
  }.each do |pkg|
    describe package(pkg) do
      it { should be_installed }
    end
  end

  if os[:family] == 'fedora'
    %w{
      gitflow
      kernel-devel
      NetworkManager-openconnect
      nmap-ncat
      python2-cinderclient
      python2-keystoneclient
      python2-openstackclient
      python2-pip
      vim-enhanced
      VirtualBox-5.1
    }.each do |pkg|
      describe package(pkg) do
        it { should be_installed }
      end
    end
    if os[:release].start_with?('25')
      describe package('NetworkManager-openconnect-gnome') do
        it { should be_installed }
      end
    end
  elsif os[:family] == 'debian'
    %w{
      git-flow
      netcat
      network-manager-openconnect-gnome
      python-cinderclient
      python-keystoneclient
      python-openstackclient
      python-pip
      vim
      virtualbox-5.1
    }.each do |pkg|
      describe package(pkg) do
        it { should be_installed }
      end
    end
  end

  describe command('/usr/local/bin/terraform -v') do
    its('stdout') { should match '0.11.7' }
  end

  describe package('vagrant') do
    it { should be_installed }
    its('version') { should match '2.1.1' }
  end

  describe pip('awscli') do
    it { should be_installed }
  end

  describe package('docker-ce') do
    it { should be_installed }
  end
end

control 'Services' do
  title 'Ensure services are running'

  describe service('docker') do
    it { should be_running }
    it { should be_enabled }
  end
end

control 'Containers' do
  title 'Ensure images are present and containers are running'

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
end
