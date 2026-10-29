{ config, ... }:

# Zed and herdr rewrite their config files when settings change in their UI,
# so link straight to the repo checkout instead of a read-only Nix store copy.
let
  dotfiles = "${config.home.homeDirectory}/config/dotfiles";
in
{
  xdg.configFile."zed/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/zed/settings.json";
  xdg.configFile."herdr/config.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/herdr/config.toml";
}
