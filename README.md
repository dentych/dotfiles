# Dentych Dotfiles

This is a collection of my dotfiles, managed with [chezmoi](https://www.chezmoi.io/).

## Installation

```bash
# Install chezmoi and apply dotfiles
chezmoi init --apply https://github.com/dentych/dotfiles.git

# Or if chezmoi is already installed
chezmoi init https://github.com/dentych/dotfiles.git
chezmoi apply
```

## Usage

```bash
# See what changes would be applied
chezmoi diff

# Apply changes
chezmoi apply

# Edit a dotfile
chezmoi edit ~/.config/fish/config.fish

# Add a new dotfile
chezmoi add ~/.config/newapp/config

# Update from remote
chezmoi update
```

## Structure

- `dot_*` files map to `~/.*` (e.g., `dot_gitconfig` → `~/.gitconfig`)
- `dot_config/` maps to `~/.config/`
- Files named `dot_gitignore` become `.gitignore` in the target location
