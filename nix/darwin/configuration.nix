{ pkgs, ... }:

{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  users.users.mcasante.home = "/Users/mcasante";

  environment.systemPackages = with pkgs; [
    git
    curl
    wget
  ];

  programs.zsh.enable = true;

  system.stateVersion = 6;
}