Clone this repo and in your home dir do:
```
find /path_to/dotfiles/home -mindepth 1 -maxdepth 1 -name '.*' ! -name .config -exec ln -s {} . \;
ln -s /path_to/dotfiles/home/.config/fish ~/.config/fish
ln -s /path_to/dotfiles/home/.config/starship.toml ~/.config/starship.toml
```

Fish setup on Fedora:
```
sudo dnf copr enable atim/starship
sudo dnf copr enable jdxcode/mise
sudo dnf install fish wl-clipboard starship mise zoxide fzf
chsh -s /usr/bin/fish
```
