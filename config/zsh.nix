{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    shellAliases = {
      # Better defaults
      ls = "eza";
      ll = "eza -la";
      cat = "bat";
      vi = "nvim";
      vim = "nvim";
      
      # Nix shortcuts
      rebuild = "sudo darwin-rebuild switch --flake ~/.config/nix";
      nixconf = "cd ~/.config/nix && nvim .";
      
      cc = "claude";
      
      # IDE shortcuts
      goland = "open -a GoLand.app";
    };

    initContent = ''
      # Check if ~/.variablerc exists, create if not, then source it
      VARIABLERC="$HOME/.variablerc"
      if [[ ! -f "$VARIABLERC" ]]; then
        cat > "$VARIABLERC" << 'EOF'
export EDITOR=nvim
EOF
        echo "Created $VARIABLERC with default content"
      fi
      source "$VARIABLERC"
    '';
  };
}
