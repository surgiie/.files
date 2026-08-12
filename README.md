# .files
My personal dotfiles for nixos.

## setup:

```bash
# create ssh key if not already present, and add to github
ssh-keygen -t ed25519 -C "your_email@example.com"

# download repo into nixos env:
nix-shell -p git --run 'git clone ssh://git@github.com/surgiie/.files.git'

# sync and build desired host
cd ~/.files
./setup --host <host>
# symlink dotfiles to home
stow home

```
