# dotfiles

For my own use.

```sh
cd $HOME
git clone https://github.com/suda-3156/dotfiles.git
cd dotfiles
chmod +x ./install.sh
./install.sh
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

These configurations need to be installed individually by executing each `setup.sh` script.

- VSCode
- Karabiner Elements

### Git

- git config

```sh
git config --global user.name <Username>
git config --global user.email <Mail address> 
```

- ssh connection to github

- git-secrets

```sh 
git secrets --install ~/.git-templates/git-secrets
git config --global init.templatedir '~/.git-templates/git-secrets'
```

### Ubuntu

When installing on Ubuntu, you need to install Neovim manually because there are several ways to do so. See below.

[Neovim Install.md](https://github.com/neovim/neovim/blob/master/INSTALL.md#linux)

### Starship

If you're in console mode or haven't installed a Nerd Font, you can use the Plain Text Symbols preset with Starship:

```sh
cd ~/dotfiles/.config/zsh
starship preset plain-text-symbols -o ./starship.toml
```

