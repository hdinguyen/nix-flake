{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    keyMode = "vi";
    mouse = true;
    prefix = "C-b";  # Default tmux prefix key
    
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavour 'mocha'
          set -g @catppuccin_window_left_separator ""
          set -g @catppuccin_window_right_separator " "
          set -g @catppuccin_window_middle_separator " █"
          set -g @catppuccin_window_number_position "right"
          set -g @catppuccin_window_default_fill "number"
          set -g @catppuccin_window_default_text "#W"
          set -g @catppuccin_window_current_fill "number"
          set -g @catppuccin_window_current_text "#W"
          set -g @catppuccin_status_modules_right "directory user host session"
          set -g @catppuccin_status_left_separator  " "
          set -g @catppuccin_status_right_separator ""
          set -g @catppuccin_status_fill "icon"
          set -g @catppuccin_status_connect_separator "no"
          set -g @catppuccin_directory_text "#{pane_current_path}"
        '';
      }
    ];
    
    extraConfig = ''
      # True color support
      set -ga terminal-overrides ",*256col*:Tc"
      
      # Start windows and panes at 1
      set -g base-index 1
      setw -g pane-base-index 1
      
      # Split panes with % and "
      bind % split-window -h
      bind '"' split-window -v
      
      # Also keep | and - bindings for convenience
      bind | split-window -h
      bind - split-window -v
      
      # Vi-style pane navigation
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
      
      # Reload config
      bind r source-file ~/.tmux.conf \; display-message "Config reloaded!"
    '';
  };
}
