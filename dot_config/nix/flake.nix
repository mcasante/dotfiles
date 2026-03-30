{
  description = "maccdasx environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    darwin.url = "github:nix-darwin/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, darwin, home-manager, ... }:
  let
    system = "aarch64-darwin";
    hostname = "Matheuss-MacBook-Air";
  in {
    darwinConfigurations.${hostname} = darwin.lib.darwinSystem {
      inherit system;

      modules = [
        ./darwin/configuration.nix

        home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";
          };
          
          home-manager.users.mcasante = {
            imports = [
              ./home/home.nix
              ./modules/shell.nix
              ./modules/node.nix
              ./modules/terminal.nix
            ];
          };
        }
      ];
    };
  };
}