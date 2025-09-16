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
      
      CC = "claude";
      CCG = "claude | glow -s auto - | less -R";
      
      # IDE shortcuts
      goland = "open -a GoLand.app";
    };

    initContent = ''
      # Check if ~/.variablerc exists, create if not, then source it
      VARIABLERC="$HOME/.variablerc"
      if [[ ! -f "$VARIABLERC" ]]; then
        cat > "$VARIABLERC" << 'EOF'
# User variables and exports
# Add your custom environment variables here
export EDITOR=nvim
export BROWSER=open
EOF
        echo "Created $VARIABLERC with default content"
      fi
      source "$VARIABLERC"

      # Custom ask function for Claude CLI
      ask() {
          if [ -t 0 ]; then
              # No piped input - stdin connected to terminal
              claude --dangerously-skip-permissions -p "@ask $*" | glow -s auto -
          else
              # Piped input detected - stdin has data from the pipe
              piped_content=$(cat)  # This reads the actual piped content
              claude --dangerously-skip-permissions -p "@ask $* 

Here's the log content:
$piped_content" | glow -s auto -
          fi
      }
    '';
  };
}
