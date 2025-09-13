# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## System Architecture

This is a Nix-based macOS configuration repository using Nix Darwin and Home Manager for system and user configuration management. The architecture follows a modular approach:

- `flake.nix`: Main entry point defining inputs (nixpkgs, nix-darwin, home-manager, nix-homebrew) and outputs
- `configuration.nix`: System-wide Darwin configuration including packages and macOS settings  
- `home.nix`: User-specific Home Manager configuration that imports modular configs
- `config/`: Directory containing modular configuration files for specific tools

## Key Commands

### System Management
```bash
# Rebuild and switch system configuration
sudo darwin-rebuild switch --flake ~/.config/nix

# Quick rebuild alias (available in shell)
rebuild

# Edit configuration
nixconf  # Changes to ~/.config/nix and opens in nvim
```

### Development Workflow
```bash
# The system includes these development tools:
# - neovim (with LazyVim configuration)
# - tmux (terminal multiplexer)  
# - git (configured with user details)
# - claude-code (this tool)
# - fzf, ripgrep, bat, eza (enhanced CLI tools)
```

## Configuration Structure

The modular configuration approach means:
- Tool-specific settings are in `config/*.nix` files
- System packages are defined in `configuration.nix` 
- User packages are defined in `config/packages.nix`
- Shell aliases and configurations are in `config/zsh.nix`

Key shell aliases available:
- `ls` → `eza` (better ls)
- `cat` → `bat` (syntax highlighted cat)
- `vi`/`vim` → `nvim` (neovim)
- `rebuild` → system rebuild command
- `cc` → `claude` (Claude desktop app)

## Package Management

This configuration uses a hybrid approach:
- **Nix**: Core development tools and CLI utilities
- **Homebrew**: GUI applications and some CLI tools via `homebrew` section in `configuration.nix`
- **Home Manager**: User-specific configurations and dotfiles

When adding packages, consider whether they should be system-wide (`configuration.nix`) or user-specific (`config/packages.nix`).