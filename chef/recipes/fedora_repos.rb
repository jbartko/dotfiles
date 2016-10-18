# Atlassian HipChat
yum_repository 'atlassian-artifactory' do
  description 'Atlassian-artifactory'
  baseurl 'http://atlassian.artifactoryonline.com/atlassian/hipchat-yum-client'
  enabled true
  gpgcheck false
end

# Atom
yum_repository '_copr_mosquito-atom' do
  description 'Copr repo for atom owned by mosquito'
  baseurl 'https://copr-be.cloud.fedoraproject.org/results/mosquito/atom/fedora-$releasever-$basearch/'
  gpgcheck true
  gpgkey 'https://copr-be.cloud.fedoraproject.org/results/mosquito/atom/pubkey.gpg'
  options({
    "enabled_metadata" => false,
    "type"             => "rpm-md",
    "repo_gpgcheck"    => false
  })
  skip_if_unavailable true
  action :create
end

# Google Chrome
yum_repository 'google-chrome' do
  description 'google-chrome'
  baseurl 'http://dl.google.com/linux/chrome/rpm/stable/x86_64'
  enabled true
  gpgcheck true
  gpgkey 'https://dl.google.com/linux/linux_signing_key.pub'
end
