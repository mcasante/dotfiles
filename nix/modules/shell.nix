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

    initContent = ''
      export PATH="$HOME/.local/bin:$PATH"

      # herdr installs itself to ~/.local/bin, outside Nix
      if command -v herdr >/dev/null; then
        source <(herdr completion zsh)
      fi
    '';
  };

  programs.starship.enable = true;
  xdg.configFile."starship.toml".source = ../../config/starship.toml;

  home.packages = with pkgs; [
    eza
    bat
    ripgrep
    fd
  ];
}
