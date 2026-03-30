{
  description = "maccdasx environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    darwin.url = "github:nix-darwin/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, darwin, home-manager, ... }:
  let
    macUsername = "mcasante";
    linuxUsernames = [ "mcasante" "ituser" ];

    darwinSystem = "aarch64-darwin";
    hostname = "Matheuss-MacBook-Air";

    homeModules = [
      ./home/home.nix
      ./modules/shell.nix
      ./modules/node.nix
      ./modules/terminal.nix
    ];

    mkHome = { system, username, homeDirectory ? null }:
      home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
        };

        modules = homeModules ++ [
          ({ pkgs, ... }: {
            home.username = username;
            home.homeDirectory =
              if homeDirectory != null
              then homeDirectory
              else if pkgs.stdenv.isDarwin
              then "/Users/${username}"
              else "/home/${username}";
          })
        ];
      };
  in {
    darwinConfigurations.${hostname} = darwin.lib.darwinSystem {
      system = darwinSystem;

      modules = [
        ./darwin/configuration.nix

        home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";
          };

          home-manager.users.${macUsername}.imports = homeModules ++ [
            {
              home.username = macUsername;
              home.homeDirectory = "/Users/${macUsername}";
            }
          ];
        }
      ];
    };

    homeConfigurations =
      builtins.listToAttrs (
        builtins.concatMap
          (username: [
            {
              name = "${username}@ubuntu";
              value = mkHome { system = "x86_64-linux"; inherit username; };
            }
            {
              name = "${username}@fedora";
              value = mkHome { system = "x86_64-linux"; inherit username; };
            }
            {
              name = "${username}@linux-aarch64";
              value = mkHome { system = "aarch64-linux"; inherit username; };
            }
          ])
          linuxUsernames
      )
      // {
        "${macUsername}@${hostname}" = mkHome {
          system = darwinSystem;
          username = macUsername;
          homeDirectory = "/Users/${macUsername}";
        };
      };
  };
}