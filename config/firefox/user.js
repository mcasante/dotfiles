// Firefox prefs applied on every start (linked into the profile by
// nix/modules/apps.nix). Firefox Sync already carries extensions, the theme,
// bookmarks and a few prefs; these are the layout bits it doesn't.
// Changing one of these in the UI only lasts until the next restart: edit here.

// Vertical tabs in a sidebar on the right that expands on hover
user_pref("sidebar.verticalTabs", true);
user_pref("sidebar.visibility", "expand-on-hover");
user_pref("sidebar.position_start", false);
user_pref("sidebar.main.tools", "aichat,syncedtabs,history,bookmarks,{446900e4-71c2-419f-a6a7-df9c091e268b}");

// Compact density, no bookmarks toolbar
user_pref("browser.uidensity", 1);
user_pref("browser.toolbars.bookmarks.visibility", "never");

// AI sidebar uses Claude
user_pref("browser.ml.chat.provider", "https://claude.ai/new");

// Don't offer to translate English or Portuguese
user_pref("browser.translations.automaticallyPopup", false);
user_pref("browser.translations.neverTranslateLanguages", "en,pt");

// New tab: Everforest background, no search box or widgets
user_pref("browser.newtabpage.activity-stream.newtabWallpapers.wallpaper", "solid-color-picker-#232a2e");
user_pref("browser.newtabpage.activity-stream.showSearch", false);
user_pref("browser.newtabpage.activity-stream.widgets.enabled", false);

// Passwords live in Bitwarden
user_pref("signon.rememberSignons", false);

user_pref("devtools.toolbox.host", "right");
