{ config, pkgs, ... }:

{
  imports = [
    ./config/packages.nix
    ./config/git.nix
    ./config/zsh.nix
    ./config/tmux.nix
    ./config/neovim.nix
    ./config/wezterm.nix
  ];

  # Home Manager state version
  home.stateVersion = "23.11";
}
