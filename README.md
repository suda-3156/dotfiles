# dotfiles

For my own use.

```sh
cd $HOME
git clone https://github.com/suda-3156/dotfiles.git
cd dotfiles
chmod +x ./scripts/install
./scripts/install
```

## Fonts

- [Moralerspace](https://github.com/yuru7/moralerspace)

```sh
curl -LO https://github.com/yuru7/moralerspace/releases/download/v1.1.0/MoralerspaceHWNF_v1.1.0.zip # check the latest release
unzip MoralerspaceHWNF_v1.1.0.zip
mv MoralerspaceHWNF_v1.1.0 ~/.fonts
fc-cache -fv
```

## TODO

- ssh connection to github
- `macos/defaults.sh`

### Ubuntu

When installing on Ubuntu, you need to install Neovim manually because there are several ways to do so. See below.

[Neovim Install.md](https://github.com/neovim/neovim/blob/master/INSTALL.md#linux)

### Starship

If you're in console mode or haven't installed a Nerd Font, you can use the Plain Text Symbols preset with Starship:

```sh
cd ~/dotfiles/.config/zsh
starship preset plain-text-symbols -o ./starship.toml
```

