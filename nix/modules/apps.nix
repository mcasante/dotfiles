{ config, inputs, lib, pkgs, ... }:

# Desktop apps that aren't part of the shell/terminal/editor setup.
lib.mkIf pkgs.stdenv.isLinux {
  home.packages = [
    # Apple Music (wraps music.apple.com; adds MPRIS, notifications, tray)
    inputs.sidra.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  # Firefox comes from Fedora and its profile folder has a random name, so link
  # config/firefox/user.js into whatever release profile exists. Firefox Sync
  # handles the rest (extensions, theme, bookmarks).
  home.activation.firefoxUserJs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    for profile in "$HOME"/.config/mozilla/firefox/*.default-release; do
      [ -d "$profile" ] || continue
      run ln -sfn "${config.home.homeDirectory}/config/dotfiles/config/firefox/user.js" "$profile/user.js"
    done
  '';
}
