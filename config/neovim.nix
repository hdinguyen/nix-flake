{ config, pkgs, ... }:

let
  lazyvim-starter = pkgs.fetchFromGitHub {
    owner = "LazyVim";
    repo = "starter";
    rev = "main";
    sha256 = "0lr0ijn3xrbg4qsva3ma5zjanxjb7qa0dsn31gw5bbzq62a6gfj2";
  };
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
    
    # LazyVim requires these packages
    extraPackages = with pkgs; [
      # Language servers
      lua-language-server
      nil  # Nix LSP
      
      # Formatters
      stylua
      nixfmt
      
      # Tools
      ripgrep
      fd
      lazygit
      
      # Build tools
      gcc
      gnumake
      unzip
      git
    ];
  };

  # LazyVim configuration files
  home.file.".config/nvim" = {
    source = lazyvim-starter;
    recursive = true;
  };
}
