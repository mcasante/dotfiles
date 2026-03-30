{ pkgs, ... }:

{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];

    always-allow-substitutes = true;

    substituters = [
      "https://cache.nixos.org"
      "https://cache.lix.systems"
      "https://nix-community.cachix.org"
    ];

    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypb6J1c2Z6iS4v5C5M5bP3hJk="
      "cache.lix.systems:aBnZUw8zA7H35Cz2RyKFVs3H4PlGTLawyY5KRbvJR8o="
      "nix-community.cachix.org-1:mB9FSj+K8y3k4M5zX1hWc9ZpQv7z3k8X5y8Z="
    ];

    max-jobs = "auto";
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