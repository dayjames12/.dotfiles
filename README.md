# .dotfiles

# 1. Clone repo into new hidden directory

```javascript
# Using ssh 
git clone git@github.com:dayjames12/.dotfiles.git ~./.dotfiles
```

# 2. Create symlinks in the home directory to the real files in the repo

```javascript
ln -s ~/.dotfiles/.bashrc ~/.bashrc
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
```

if on windows using PowerShell
```javascript
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.bashrc" -Target "$(Get-Location)\.dotfiles\.bashrc"
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.gitconfig" -Target "$(Get-Location)\.dotfiles\.gitconfig"
New-Item -ItemType SymbolicLink -Path "$env:LOCALAPPDATA\nvim" -Target "$env:USERPROFILE\.dotfiles\nvim"
New-Item -ItemType SymbolicLink -Path "$env:APPDATA\alacritty\alacritty.toml" -Target "$env:USERPROFILE\.dotfiles\alacritty.toml" -Force
```

examples of commands for powershell when file already exists
```javascript
Rename-Item "$env:USERPROFILE\.bashrc" "$env:USERPROFILE\.bashrc.backup"
Rename-Item "$env:USERPROFILE\.gitconfig" "$env:USERPROFILE\.gitconfig.backup"
```


