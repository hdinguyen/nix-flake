{ config, pkgs, ... }:

{
  # User-specific packages
  home.packages = with pkgs; [
    # Additional CLI tools
    fzf       # Fuzzy finder
    ripgrep   # Better grep
    bat       # Better cat
    eza       # Better ls
    htop      # Process viewer
    jq        # JSON processor
    glow      # Markdown terminal reader
    
    # Development tools
    docker         # Docker CLI (Desktop app via Homebrew)
    nodejs_latest  # Node.js latest LTS (24.x)
    uv            # Python package manager (fast pip/poetry alternative)
  ];
}
