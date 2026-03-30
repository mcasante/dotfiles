{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fzf
    # ghostty-bin
    zellij
  ];
}