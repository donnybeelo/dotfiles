#!/bin/bash
#
# Dotfiles installation script
# This script installs the dotfiles to your home directory.

filesToIgnore=("README.md" "install.sh" ".gitignore")

distro=$(awk -F= '/^ID=/{print $2}' /etc/os-release | tr -d '"')

if [[ "$distro" == "arch" || "$distro" == "manjaro" ]]; then
	distro="arch"
	sudo pacman -Sy --noconfirm git curl flatpak base-devel emacs-nox xdg-utils unzip
	# Install yay AUR helper
	git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si
elif [[ "$distro" == "ubuntu" || "$distro" == "debian" ]]; then
	distro="debian"
	sudo apt update && sudo apt install -y git curl flatpak build-essential emacs-nox xdg-utils unzip
else
	echo "Unsupported distribution. Exiting."
	exit 1
fi

# Check if we're running from a git clone or need to clone to tmp
if [ -d ".git" ] && git config --get remote.origin.url | grep -q "donnybeelo/dotfiles"; then
	DOTFILES_DIR="$(pwd)"
else
	rm -rf /tmp/dotfiles
	git clone --depth 1 https://github.com/donnybeelo/dotfiles.git /tmp/dotfiles
	DOTFILES_DIR="/tmp/dotfiles"
fi

for file in "$DOTFILES_DIR"/*; do
	filename=$(basename "$file")
	if [[ ${filesToIgnore[@]} =~ $filename ]] || [[ ! -f "$file" ]]; then
		continue
	fi
	if [[ "$DOTFILES_DIR" = "/tmp/dotfiles" ]]; then
		cp "/tmp/dotfiles/$filename" "$HOME/.$filename"
	else
		ln -sf "$DOTFILES_DIR/$filename" "$HOME/$filename"
	fi
done

if [[ "$DOTFILES_DIR" = "/tmp/dotfiles" ]]; then
	cp -r /tmp/dotfiles/config/* $HOME/.config
	cp /tmp/dotfiles/bashrc/bashrc_mold $HOME/.custom_bashrc
	case "$distro" in
		"arch") cp /tmp/dotfiles/bashrc/arch_bashrc $HOME/.extra_bashrc ;;
		"debian") cp /tmp/dotfiles/bashrc/ubuntu_bashrc $HOME/.extra_bashrc ;;
	esac
else
	ln -sf $DOTFILES_DIR/config/* $HOME/.config/
	ln -sf $DOTFILES_DIR/bashrc/bashrc_mold $HOME/.custom_bashrc
	case "$distro" in
		"arch") ln -sf /tmp/dotfiles/bashrc/arch_bashrc $HOME/.extra_bashrc ;;
		"debian") ln -sf /tmp/dotfiles/bashrc/ubuntu_bashrc $HOME/.extra_bashrc ;;
	esac
fi

# Add custom bashrc sourcing if not already present
if ! grep -q "source \$HOME/.custom_bashrc" "$HOME/.bashrc"; then
	echo "source \$HOME/.custom_bashrc" >> "$HOME/.bashrc"
fi

[ ! -d "$HOME/.complete_alias" ] && git clone --depth 1 https://github.com/cykerway/complete-alias.git ~/.complete_alias

if ! command -v bun &> /dev/null; then
	echo "Bun not found, installing Bun..."
	curl -fsSL https://bun.com/install | bash
fi

# Clean up if we cloned to tmp
if [[ "$DOTFILES_DIR" = "/tmp/dotfiles" ]]; then
	rm -rf /tmp/dotfiles
fi

mkdir $HOME/git