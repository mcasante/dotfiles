{ pkgs, ... }:

{
  home.stateVersion = "24.11";

  programs.atuin = {
    enable = true;
    settings = {
      auto_sync = true;
      sync_frequency = "5m";
      sync_address = "https://api.atuin.sh";
      search_mode = "fuzzy";
    };
  };

  programs.git = {
    enable = true;
    settings.user.name = "mcasante";
    settings.user.email = "matheus.casante@gmail.com";
  };
}