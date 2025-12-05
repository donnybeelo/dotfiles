# My dotfiles

This repository contains my personal dotfiles for configuring various applications and tools on my system. These files help me maintain a consistent environment across different machines.

To run once and forget (this will make a temp directory, copy the files over, and clean up after):

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/donnybeelo/dotfiles/main/install.sh)"
```
To clone and keep up to date (this will symlink the files from this repo instead):

```sh
git clone https://github.com/donnybeelo/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
chmod +x install.sh
./install.sh
```