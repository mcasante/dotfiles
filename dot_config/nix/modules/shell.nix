{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -la";
      gs = "git status";
    };

    initExtra = ''
      export PATH="$HOME/.local/bin:$PATH"
      
      # bun
      export BUN_INSTALL="$HOME/.bun"
      export PATH="$BUN_INSTALL/bin:$PATH"
    '';
  };

  programs.starship.enable = true;

  home.packages = with pkgs; [
    zellij
    eza
    bat
    ripgrep
    fd
  ];
}