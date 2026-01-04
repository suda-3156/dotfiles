# VSCode

```sh
./vscode/install.common
```

- (Optional) If needed, run the Command Palette command to install the 'code' command in your PATH.

- `code --list-extensions > ~/dotfiles/vscode/extensions`: list extensions
- Uninstall all extensions

```sh
for list in $(code --list-extensions); do
  code --uninstall-extensions "$list"
done
```
