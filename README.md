# .dotfiles

# 1. Clone repo into new hidden directory

```javascript
# Using ssh 
git clone git@github.com:dayjames12/.dotfiles.git ~./dotfiles
```

# 2. Create symlinks in the home directory to the real files in the repo

```javascript
ln -s ~/.dotfiles/.bashrc ~/.bashrc
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
```
