# Atlassian HipChat
yum_repository 'atlassian-artifactory' do
  description 'Atlassian-artifactory'
  baseurl 'http://atlassian.artifactoryonline.com/atlassian/hipchat-yum-client'
  enabled true
  gpgcheck false
end

# Atom
# yum_repository '_copr_mosquito-atom' do
#   description 'Copr repo for atom owned by mosquito'
#   baseurl 'https://copr-be.cloud.fedoraproject.org/results/mosquito/atom/fedora-$releasever-$basearch/'
#   gpgcheck true
#   gpgkey 'https://copr-be.cloud.fedoraproject.org/results/mosquito/atom/pubkey.gpg'
#   options({
#     "enabled_metadata" => false,
#     "type"             => "rpm-md",
#     "repo_gpgcheck"    => false
#   })
#   skip_if_unavailable true
#   action :create
# end

# fedorainfracloud.org/coprs now offline :(
# https://fedoraproject.org/wiki/Atom
bash 'install_update_atom' do
  code <<-EOF
  ATOM_INSTALLED_VERSION=$(rpm -qi atom | grep "Version" |  cut -d ':' -f 2 | cut -d ' ' -f 2)
  ATOM_LATEST_VERSION=$(curl -sL "https://api.github.com/repos/atom/atom/releases/latest" | grep -E "https.*atom-amd64.tar.gz" | cut -d '"' -f 4 | cut -d '/' -f 8 | sed 's/v//g')

  if [[ $ATOM_INSTALLED_VERSION < $ATOM_LATEST_VERSION ]]; then
    dnf install -y https://github.com/atom/atom/releases/download/v${ATOM_LATEST_VERSION}/atom.x86_64.rpm
  fi
  EOF
end

# Google Chrome
yum_repository 'google-chrome' do
  description 'google-chrome'
  baseurl 'http://dl.google.com/linux/chrome/rpm/stable/x86_64'
  enabled true
  gpgcheck true
  gpgkey 'https://dl.google.com/linux/linux_signing_key.pub'
end
