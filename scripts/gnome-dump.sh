#!/usr/bin/env bash
# Snapshot GNOME settings into config/gnome/ (applied by nix/modules/gnome.nix).
# Re-run after changing settings in the GUI, then review the diff and commit.
set -euo pipefail

out="$(cd "$(dirname "$0")/.." && pwd)/config/gnome"
mkdir -p "$out"

# dump <dconf dir> <file> <sections to keep> [keys to drop]
dump() {
  dconf dump "$1" | KEEP="$3" DROP="${4:-}" awk '
    BEGIN          { keep = ENVIRON["KEEP"]; drop = ENVIRON["DROP"] }
    /^\[/          { insec = ($0 ~ keep); if (insec) { if (n++) print ""; print }; next }
    !insec || /^$/ { next }
    drop != "" && $0 ~ drop { next }
    { print }
  ' > "$out/$2.ini"
}

# Shell: extension list, dock favorites and extension settings. PaperWM
# workspace UUIDs and its saved copies of the stock keybindings are per-machine.
dump /org/gnome/shell/ shell \
  '^\[(/|extensions/(blur-my-shell.*|dash-to-panel|extension-list|paperwm|paperwm/keybindings))\]$' \
  '^(app-picker-layout|command-history|welcome-dialog-last-shown-version|last-selected-power-profile|restore-[a-z-]+|last-used-display-server|prefs-opened|intellihide-persisted-state|extension-version|settings-version)='

dump /org/gnome/desktop/ desktop \
  '^\[(interface|wm/preferences|peripherals/keyboard|peripherals/touchpad|input-sources)\]$' \
  '^(current|mru-sources|numlock-state)='

dump /org/gnome/mutter/ mutter '^\[/\]$'
