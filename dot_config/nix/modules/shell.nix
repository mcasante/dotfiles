{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    shellAliases = {
      ll = "ls -la";
      gs = "git status";
    };
  };

  home.packages = with pkgs; [
    zellij
    eza
    bat
    ripgrep
    fd
  ];
}