{ config, lib, pkgs, ... }:

# niri + DankMaterialShell, installed from Fedora/COPR (see the comment in
# config/niri/config.kdl). DMS writes into its own folders and appends includes
# to config.kdl from its Settings UI, so these link to the repo checkout rather
# than read-only Nix store copies. Settings changed in the DMS UI land in
# config/dms/settings.json and config/niri/dms/, so they show up in git status.
let
  dotfiles = "${config.home.homeDirectory}/config/dotfiles";
  link = path: config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${path}";
in
lib.mkIf pkgs.stdenv.isLinux {
  xdg.configFile."niri/config.kdl".source = link "config/niri/config.kdl";
  # DMS writes its generated includes (binds, layout, colors...) here
  xdg.configFile."niri/dms".source = link "config/niri/dms";
  xdg.configFile."dms/themes/everforest.json".source = link "config/dms/themes/everforest.json";
  xdg.configFile."dms/config.d/theme.json".source = link "config/dms/config.d/theme.json";
  xdg.configFile."dms/settings.json".source = link "config/dms/settings.json";
  # ~/.local/share/wallpapers; pick one with Mod+Y or `dms ipc call wallpaper set <path>`
  xdg.dataFile."wallpapers".source = link "wallpapers";
}
