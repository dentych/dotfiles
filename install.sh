# !/bin/bash

command_exist() {
	command -v "$1" >/dev/null 2>&1
}

if ! command_exist brew; then
	echo 'Homebrew not found'
	exit -1
fi

# Install brew packages
echo 'Updating Homebrew...'
brew update

echo 'Installing packages...'
brew bundle --file=./Brewfile

# Symlink dotfiles
echo 'Copying and linking dotfiles...'
stow -v --no-folding aerospace fish foot ghostty hypr nvim waybar zellij git editorconfig tmux
