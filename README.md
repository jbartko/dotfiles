# [fresh](https://freshshell.com/) ~/.dotfiles

## Why hello there
You're probably here for [OpenSSL wrappers](bash/openssl-wrappers) or [Consul curl wrappers](bash/consul_curl). Add something like the following to your own `freshrc`:

```
fresh https://git.drillinginfo.com/john-bartko/dotfiles.git bash/consul_curl
```

## Installation
``` sh
FRESH_LOCAL_SOURCE=https://git.drillinginfo.com/john-bartko/dotfiles.git bash -c "`curl -sL get.freshshell.com`"
echo 'source ~/.fresh/build/shell.sh' | tee -a ~/.bashrc
source ~/.bashrc
```

## Full workstation bootstrap

1. Install dotfiles as above
2. `chef-workstation-bootstrap -j ~/.dotfiles/chef/dna.json`
