{ config, pkgs, ... }:

{
  home.file.".config/wezterm/wezterm.lua".text = ''
    local wezterm = require 'wezterm'
    local config = {}

    -- Font
    config.font = wezterm.font('JetBrains Mono')
    config.font_size = 14.0

    -- Theme
    config.color_scheme = 'Catppuccin Mocha'

    -- Window
    config.window_decorations = "RESIZE"
    config.enable_tab_bar = false

    -- Key bindings
    config.keys = {
      -- Split panes (iTerm-style)
      { key = 'd', mods = 'CMD', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
      { key = 'd', mods = 'CMD|SHIFT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
      
      -- Pane navigation
      { key = '[', mods = 'CMD', action = wezterm.action.ActivatePaneDirection 'Prev' },
      { key = ']', mods = 'CMD', action = wezterm.action.ActivatePaneDirection 'Next' },
      
      -- Copy mode (Ctrl + Shift + X)
      { key = 'X', mods = 'CTRL|SHIFT', action = wezterm.action.ActivateCopyMode },
      
      -- Shift+Enter sends escape+return
      { key = "Enter", mods = "SHIFT", action = wezterm.action{SendString="\x1b\r"} },
      
      -- Alt + arrow keys for word navigation
      { key = "LeftArrow", mods = "ALT", action = wezterm.action{SendString="\x1bb"} },
      { key = "RightArrow", mods = "ALT", action = wezterm.action{SendString="\x1bf"} },
      
      -- Cmd + arrow keys for line navigation
      { key = "LeftArrow", mods = "CMD", action = wezterm.action{SendString="\x01"} },
      { key = "RightArrow", mods = "CMD", action = wezterm.action{SendString="\x05"} },
    }

    -- Copy mode vim-like keybindings
    config.key_tables = {
      copy_mode = {
        -- Navigation - basic movement
        { key = 'h', mods = 'NONE', action = wezterm.action.CopyMode 'MoveLeft' },
        { key = 'j', mods = 'NONE', action = wezterm.action.CopyMode 'MoveDown' },
        { key = 'k', mods = 'NONE', action = wezterm.action.CopyMode 'MoveUp' },
        { key = 'l', mods = 'NONE', action = wezterm.action.CopyMode 'MoveRight' },
        
        -- Arrow keys for navigation (fallback)
        { key = 'LeftArrow', mods = 'NONE', action = wezterm.action.CopyMode 'MoveLeft' },
        { key = 'RightArrow', mods = 'NONE', action = wezterm.action.CopyMode 'MoveRight' },
        { key = 'UpArrow', mods = 'NONE', action = wezterm.action.CopyMode 'MoveUp' },
        { key = 'DownArrow', mods = 'NONE', action = wezterm.action.CopyMode 'MoveDown' },
        
        -- Word movement
        { key = 'w', mods = 'NONE', action = wezterm.action.CopyMode 'MoveForwardWord' },
        { key = 'b', mods = 'NONE', action = wezterm.action.CopyMode 'MoveBackwardWord' },
        { key = 'e', mods = 'NONE', action = wezterm.action.CopyMode 'MoveForwardWordEnd' },
        
        -- Line navigation
        { key = '0', mods = 'NONE', action = wezterm.action.CopyMode 'MoveToStartOfLine' },
        { key = '^', mods = 'NONE', action = wezterm.action.CopyMode 'MoveToStartOfLineContent' },
        { key = '$', mods = 'NONE', action = wezterm.action.CopyMode 'MoveToEndOfLineContent' },
        
        -- Page navigation
        { key = 'g', mods = 'NONE', action = wezterm.action.CopyMode 'MoveToScrollbackTop' },
        { key = 'G', mods = 'NONE', action = wezterm.action.CopyMode 'MoveToScrollbackBottom' },
        { key = 'u', mods = 'CTRL', action = wezterm.action.CopyMode 'PageUp' },
        { key = 'd', mods = 'CTRL', action = wezterm.action.CopyMode 'PageDown' },
        
        -- Jump to line (G with numbers)
        { key = '1', mods = 'NONE', action = wezterm.action.CopyMode { SetSelectionMode = 'SemanticZone' } },
        { key = '2', mods = 'NONE', action = wezterm.action.CopyMode { SetSelectionMode = 'SemanticZone' } },
        { key = '3', mods = 'NONE', action = wezterm.action.CopyMode { SetSelectionMode = 'SemanticZone' } },
        { key = '4', mods = 'NONE', action = wezterm.action.CopyMode { SetSelectionMode = 'SemanticZone' } },
        { key = '5', mods = 'NONE', action = wezterm.action.CopyMode { SetSelectionMode = 'SemanticZone' } },
        { key = '6', mods = 'NONE', action = wezterm.action.CopyMode { SetSelectionMode = 'SemanticZone' } },
        { key = '7', mods = 'NONE', action = wezterm.action.CopyMode { SetSelectionMode = 'SemanticZone' } },
        { key = '8', mods = 'NONE', action = wezterm.action.CopyMode { SetSelectionMode = 'SemanticZone' } },
        { key = '9', mods = 'NONE', action = wezterm.action.CopyMode { SetSelectionMode = 'SemanticZone' } },
        
        -- Search
        { key = '/', mods = 'NONE', action = wezterm.action.Search { CaseSensitiveString = "" } },
        { key = '?', mods = 'NONE', action = wezterm.action.Search { CaseInSensitiveString = "" } },
        { key = 'n', mods = 'NONE', action = wezterm.action.CopyMode 'NextMatch' },
        { key = 'N', mods = 'NONE', action = wezterm.action.CopyMode 'PriorMatch' },
        
        -- Selection modes
        { key = 'v', mods = 'NONE', action = wezterm.action.CopyMode { SetSelectionMode = 'Cell' } },
        { key = 'V', mods = 'NONE', action = wezterm.action.CopyMode { SetSelectionMode = 'Line' } },
        { key = 'v', mods = 'CTRL', action = wezterm.action.CopyMode { SetSelectionMode = 'Block' } },
        
        -- Copy and exit
        { key = 'y', mods = 'NONE', action = wezterm.action.Multiple {
            { CopyTo = 'ClipboardAndPrimarySelection' },
            { CopyMode = 'Close' }
          }
        },
        { key = 'Enter', mods = 'NONE', action = wezterm.action.Multiple {
            { CopyTo = 'ClipboardAndPrimarySelection' },
            { CopyMode = 'Close' }
          }
        },
        
        -- Exit copy mode
        { key = 'Escape', mods = 'NONE', action = wezterm.action.CopyMode 'Close' },
        { key = 'q', mods = 'NONE', action = wezterm.action.CopyMode 'Close' },
        { key = 'c', mods = 'CTRL', action = wezterm.action.CopyMode 'Close' },
      },
      
      search_mode = {
        { key = 'Enter', mods = 'NONE', action = wezterm.action.CopyMode 'PriorMatch' },
        { key = 'Escape', mods = 'NONE', action = wezterm.action.CopyMode 'Close' },
        { key = 'n', mods = 'CTRL', action = wezterm.action.CopyMode 'NextMatch' },
        { key = 'p', mods = 'CTRL', action = wezterm.action.CopyMode 'PriorMatch' },
        { key = 'r', mods = 'CTRL', action = wezterm.action.CopyMode 'CycleMatchType' },
        { key = 'u', mods = 'CTRL', action = wezterm.action.CopyMode 'ClearPattern' },
      },
    }

    return config
  '';
}
