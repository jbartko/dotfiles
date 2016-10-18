# [fresh](https://freshshell.com/) ~/.dotfiles

## Installation
``` sh
FRESH_LOCAL_SOURCE=https://git.drillinginfo.com/john-bartko/dotfiles.git bash -c "`curl -sL get.freshshell.com`"
```

## Full workstation bootstrap

1. Install dotfiles as above
2. `chef-workstation-bootstrap -j ~/.dotfiles/chef/dna.json`
