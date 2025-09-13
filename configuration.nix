{ config, pkgs, ... }:

let
  username = "nguyenh";
in
{
  nixpkgs.config.allowUnfree = true;
  # User configuration
  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };

  # Set the primary user for system-wide settings (REQUIRED for new nix-darwin)
  system.primaryUser = username;

  # Nix settings
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ username "root" ];
  };

  # System packages (installed globally)
  environment.systemPackages = with pkgs; [
    # Core development tools from Nix
    wezterm   
    neovim    # Text editor
    tmux      # Terminal multiplexer
    git       # Version control
    curl      # HTTP client
    wget      # File downloader
    tree      # Directory viewer
    claude-code
    aerospace
    raycast
    vscode
  ];

  # Homebrew for GUI applications
  homebrew = {
    enable = true;
    
    # Brew packages (CLI tools)
    brews = [
      "mas"  # Mac App Store CLI
    ];
    
    # Cask applications (GUI apps)
    casks = [
      "claude"               # Claude desktop client  
      "docker"               # Docker Desktop
      "hiddenbar"            # Hide menu bar items
      "openkey"              # Vietnamese input method
    ];
    
    # Mac App Store apps
    masApps = {
      "Owly" = 882812218;  # Prevent display sleep
    };

    # Clean up old/unused packages
    onActivation.cleanup = "none";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };

  # Enable shells
  programs.zsh.enable = true;

  # Basic macOS settings
  system.defaults = {
    dock.autohide = true;
    finder.AppleShowAllExtensions = true;
    NSGlobalDomain.KeyRepeat = 1;
    NSGlobalDomain.InitialKeyRepeat = 14;
  };

  # System version
  system.stateVersion = 5;
  
  # Set platform (change to x86_64-darwin for Intel Macs)
  nixpkgs.hostPlatform = "aarch64-darwin";
}
