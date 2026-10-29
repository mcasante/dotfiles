{ lib, pkgs, ... }:

# GNOME settings live as dconf snapshots in config/gnome/ (refresh them with
# scripts/gnome-dump.sh). They are loaded on every switch, so GUI changes that
# weren't dumped back get overwritten. Extensions themselves are installed from
# extensions.gnome.org, since nixpkgs builds may not match the host's GNOME Shell.
let
  gnome = ../../config/gnome;
in
lib.mkIf pkgs.stdenv.isLinux {
  home.activation.gnomeSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if command -v gnome-shell >/dev/null && [ -n "''${DBUS_SESSION_BUS_ADDRESS:-}" ]; then
      run ${pkgs.dconf}/bin/dconf load /org/gnome/shell/ < ${gnome}/shell.ini
      run ${pkgs.dconf}/bin/dconf load /org/gnome/desktop/ < ${gnome}/desktop.ini
      run ${pkgs.dconf}/bin/dconf load /org/gnome/mutter/ < ${gnome}/mutter.ini
    fi
  '';
}
