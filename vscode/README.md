# VSCode

## Install Visual Studio Code

`brew install --cask visual-studio-code`

## Set up

1. (Optional) If needed, run the Command Palette command to install the 'code' command in your PATH.
2. Run `install.sh`.

- This script will:
  - Create symbolic links for:
    - `${HOME}/Library/Application Support/Code/User/settings.json` linked to `vscode/settings.json`
    - `${HOME}/Library/Application Support/Code/User/keybindings.json` linked to `vscode/keybindings.json`
  - Install extensions listed in `vscode/extensions`

## List Extensions

- `code --list-extensions > ~/dotfiles/vscode/extensions`
- `code --install-extension`
