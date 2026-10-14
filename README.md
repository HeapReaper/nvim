# 💤 Neovim with LazyVim

My personal NeoVim setup to make NeoVim my great text editor & IDE

## Installing NeoVim

1. `sudo apt install -y git curl unzip ripgrep fd-find neovim`

## Configure NeoVim to use this config

1. `mkdir -p ~/nvim-backup`
2. `cp -a ~/.config/nvim ~/nvim-backup/config-nvim 2>/dev/null || true`
3. Optional: `rm -rf ~/.config/nvim`
4. `git clone https://codeberg.org/HeapReaper/nvim-config.git ~/.config/nvim`

## Configure capslock as escape

1. (On Linux) `gsettings set org.gnome.desktop.input-sources xkb-options "['caps:escape']`

## Setting up a terminal background

1. Install Ghostty: `sudo apt install ghostty`
2. Open config: `nvim ~/.config/ghostty/config`
3. Add the following:

```
background-image = ~/.config/nvim/bg2.jpg
background-image-opacity = 0.15
background-opacity = 0.90
```

1. Restart Ghostty
