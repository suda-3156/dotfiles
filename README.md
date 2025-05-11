# dotfiles

For my own use.

## Fonts

- [Moralerspace](https://github.com/yuru7/moralerspace)

```sh
curl -LO https://github.com/yuru7/moralerspace/releases/download/v1.1.0/MoralerspaceHWNF_v1.1.0.zip # check the latest release
unzip MoralerspaceHWNF_v1.1.0.zip
mv MoralerspaceHWNF_v1.1.0 ~/.fonts
fc-cache -fv
```

I prefer the `Terminus` font in console mode.

```sh
sudo dpkg-reconfigure console-setup
```

## Note

These configurations need to be installed individually by executing each `setup.sh` script.

- VSCode
- Karabiner Elements

## Homebrew

I didn’t install these apps using Homebrew this time, but I will next time.

- Raycast
- Docker
- VSCode
- Obsidian
- AppCleaner
- KeyboardCleanTool
- Discord
- Postman
- Firefox
- Clipy

## TODO

- git config

```sh
git config --global user.name <Username>
git config --global user.email <Mail address> 
```

- ssh connection to github

### Ubuntu

When installing on Ubuntu, you need to install Neovim manually because there are several ways to do so. See below.

[Neovim Install.md](https://github.com/neovim/neovim/blob/master/INSTALL.md#linux)

If you're in console mode or haven't installed a Nerd Font, you can use the Plain Text Symbols preset with Starship:

```sh
cd ~/dotfiles/.config/zsh
starship preset plain-text-symbols -o ./starship.toml
```

