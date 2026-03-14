# After execute install script, do

- setup ssh connection to github
- `macos/defaults.sh` if needed

## Ubuntu

When installing on Ubuntu, you need to install Neovim manually because there are several ways to do so. See below.

[Neovim Install.md](https://github.com/neovim/neovim/blob/master/INSTALL.md#linux)

## Starship

If you're in console mode or haven't installed a Nerd Font, you can use the Plain Text Symbols preset with Starship:

```sh
cd ~/dotfiles/.config/zsh
starship preset plain-text-symbols -o ./starship.toml
```

