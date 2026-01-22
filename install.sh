# !/bin/bash

command_exist() {
	command -v "$1" >/dev/null 2>&1
}

# Install brew packages if Homebrew is available
if command_exist brew; then
	echo 'Homebrew found - installing packages...'
	echo 'Updating Homebrew...'
	brew update

	echo 'Installing packages...'
	brew bundle --file=./Brewfile
else
	echo 'Homebrew not found - skipping package installation'
fi

# Symlink dotfiles
echo 'Copying and linking dotfiles wit no folding...'
stow -v --no-folding aerospace fish foot ghostty hypr waybar zellij git editorconfig tmux starship alacritty helix
echo 'Copying and linking dotfiles with folding'
stow -v nvim
