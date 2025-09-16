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

  # Custom init.lua - loads LazyVim
  home.file.".config/nvim/init.lua".text = ''
    -- bootstrap lazy.nvim, LazyVim and your plugins
    require("config.lazy")
  '';
  
  # Copy the LazyVim config directory, but we'll override keymaps.lua
  home.file.".config/nvim/lua/config/autocmds.lua".source = "${lazyvim-starter}/lua/config/autocmds.lua";
  home.file.".config/nvim/lua/config/lazy.lua".source = "${lazyvim-starter}/lua/config/lazy.lua";
  home.file.".config/nvim/lua/config/options.lua".source = "${lazyvim-starter}/lua/config/options.lua";
  
  # Copy the plugins directory
  home.file.".config/nvim/lua/plugins" = {
    source = "${lazyvim-starter}/lua/plugins";
    recursive = true;
  };
  
  # Copy other necessary files
  home.file.".config/nvim/.gitignore".source = "${lazyvim-starter}/.gitignore";
  home.file.".config/nvim/stylua.toml".source = "${lazyvim-starter}/stylua.toml";
  home.file.".config/nvim/LICENSE".source = "${lazyvim-starter}/LICENSE";
  home.file.".config/nvim/README.md".source = "${lazyvim-starter}/README.md";

  # Custom plugin configuration for claudecode.nvim with --dangerously-skip-permissions
  home.file.".config/nvim/lua/plugins/claudecode.lua".text = ''
    return {
      {
        "coder/claudecode.nvim",
        dependencies = { "folke/snacks.nvim" },
        opts = {
          terminal_cmd = "claude --dangerously-skip-permissions",
        },
        config = true,
        keys = {
          { "<leader>a", nil, desc = "AI/Claude Code" },
          { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
          { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
          { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
          { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
          { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
          { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
          { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
          {
            "<leader>as",
            "<cmd>ClaudeCodeTreeAdd<cr>",
            desc = "Add file",
            ft = { "NvimTree", "neo-tree", "oil", "minifiles" },
          },
          -- Diff management
          { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
          { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
        },
      },
    }
  '';

  # Custom keymaps configuration
  home.file.".config/nvim/lua/config/keymaps.lua".text = ''
    -- Keymaps are automatically loaded on the VeryLazy event
    -- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
    -- Add any additional keymaps here

    local map = vim.keymap.set

    -- Terminal mode: quick jk to exit terminal mode (C-\ C-n)
    map("t", "jk", "<C-\\><C-n>", { desc = "Exit terminal mode" })

    -- Window navigation: C-h and C-j for window movement
    map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
    map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })

    -- Configure yank to copy directly to clipboard
    map({"n", "v"}, "y", '"+y', { desc = "Yank to clipboard" })
    map("n", "Y", '"+Y', { desc = "Yank line to clipboard" })
  '';
}
