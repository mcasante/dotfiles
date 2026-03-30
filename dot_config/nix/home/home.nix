{ pkgs, ... }:

{
  home.stateVersion = "24.11";

  programs.git = {
    enable = true;
    userName = "mcasante";
    userEmail = "matheus.casante@gmail.com";
  };
}