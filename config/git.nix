{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Nguyen Huynh";
    userEmail = "hdinguyen@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "nvim";
    };
  };
}
