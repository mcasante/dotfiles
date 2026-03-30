{ pkgs, ... }:

{
  home.stateVersion = "24.11";

  programs.git = {
    enable = true;
    settings.user.name = "mcasante";
    settings.user.email = "matheus.casante@gmail.com";
  };
}