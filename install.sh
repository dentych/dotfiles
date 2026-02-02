# !/bin/bash

command_exist() {
	command -v "$1" >/dev/null 2>&1
}

# Install brew packages if Homebrew is available (only once every 24 hours)
BREW_LAST_RUN_FILE="$(dirname "$0")/.brew_last_run"
SECONDS_IN_DAY=86400

should_run_brew() {
	if [ ! -f "$BREW_LAST_RUN_FILE" ]; then
		return 0
	fi
	last_run=$(cat "$BREW_LAST_RUN_FILE")
	current_time=$(date +%s)
	elapsed=$((current_time - last_run))
	[ "$elapsed" -ge "$SECONDS_IN_DAY" ]
}

if command_exist brew; then
	if should_run_brew; then
		echo 'Homebrew found - installing packages...'
		echo 'Updating Homebrew...'
		brew update

		echo 'Installing packages...'
		brew bundle --file=./Brewfile

		date +%s > "$BREW_LAST_RUN_FILE"
	else
		echo 'Homebrew was updated less than 24 hours ago - skipping'
	fi
else
	echo 'Homebrew not found - skipping package installation'
fi

# Install stow if not available
if ! command_exist stow; then
	echo 'stow not found - installing...'
	if command_exist brew; then
		brew install stow
	elif command_exist apt; then
		sudo apt update && sudo apt install -y stow
	elif command_exist dnf; then
		sudo dnf install -y stow
	elif command_exist pacman; then
		sudo pacman -S --noconfirm stow
	else
		echo 'Error: No supported package manager found. Please install stow manually.'
		exit 1
	fi

	if ! command_exist stow; then
		echo 'Error: Failed to install stow. Please install it manually.'
		exit 1
	fi
fi

# Symlink dotfiles
echo 'Copying and linking dotfiles with no folding...'
stow -v --no-folding aerospace fish foot ghostty hypr waybar zellij git editorconfig tmux starship alacritty helix
echo 'Copying and linking dotfiles with folding'
stow -v nvim
