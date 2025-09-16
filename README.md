# My nvim configuration

## Requirements
- node.js for `coc.nvim`

## Installation

- Make a backup of your current Neovim files:

```bash
# required
mv ~/.config/nvim{,.bak}

# optional but recommended
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}
```

- Clone this repository:

```bash
git clone https://github.com/afloetotto/nvim-config ~/.config/nvim
```

If you now start neovim with `nvim`, it should load the configuration and probably display a few errors because the plugins are not installed yet.
This config uses and automatically installs the plugin manager `vim-plug`.
You can install all plugins defined in the config using the vim command `PlugInstall`.
