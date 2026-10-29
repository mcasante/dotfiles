{ config, lib, pkgs, ... }:

# niri + DankMaterialShell, installed from Fedora/COPR (see the comment in
# config/niri/config.kdl). DMS writes into its own folders and appends includes
# to config.kdl from its Settings UI, so these link to the repo checkout rather
# than read-only Nix store copies. DMS-generated files (~/.config/niri/dms/,
# ~/.config/dms/settings.json) stay out of the repo.
let
  dotfiles = "${config.home.homeDirectory}/config/dotfiles";
  link = path: config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${path}";
in
lib.mkIf pkgs.stdenv.isLinux {
  xdg.configFile."niri/config.kdl".source = link "config/niri/config.kdl";
  xdg.configFile."dms/themes/everforest.json".source = link "config/dms/themes/everforest.json";
  xdg.configFile."dms/config.d/theme.json".source = link "config/dms/config.d/theme.json";
}
