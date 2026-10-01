Clone this repo and run:
```
./install.sh
```
It symlinks everything under `home/` into `~`. Safe to re-run. Existing regular
files are skipped, so remove `~/.config/fish` first if fish already created it.

Machine-specific things (tokens, work-only functions) go in
`~/.config/fish/conf.d/local.fish`, which is gitignored and loaded by fish automatically.

Fish setup on Fedora:
```
sudo dnf copr enable atim/starship
sudo dnf copr enable jdxcode/mise
sudo dnf install fish wl-clipboard starship mise zoxide fzf
chsh -s /usr/bin/fish
```

The VS Code settings link assumes the RPM build. The Flatpak keeps its config in
`~/.var/app/com.visualstudio.code/config/Code/User` instead.
