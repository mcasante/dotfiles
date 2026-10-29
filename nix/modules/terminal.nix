{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fzf
    # ghostty-bin
    zellij
  ];

  xdg.configFile."ghostty/config".source = ../../config/ghostty/config;
  xdg.configFile."zellij/config.kdl".source = ../../config/zellij/config.kdl;
}
