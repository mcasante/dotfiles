{ pkgs, ... }:

{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];

    substituters = [
      "https://cache.nixos.org"
    ];

    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypb6J1c2Z6iS4v5C5M5bP3hJk="
    ];
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