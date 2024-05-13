{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gnome.dconf-editor
    gnome.gnome-tweaks
    gnomeExtensions.tiling-assistant
  ];

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;

      # `gnome-extensions list` for a list
      enabled-extensions = [
        "tiling-assistant@leleat-on-github"
      ];
      favorite-apps = [
        "nautilus.desktop"
        "kitty.desktop"
        "firefox.desktop"
      ];
    };
    "org/gnome/shell/extensions/tiling-assistant" = {
      single-screen-gap = 20;
      window-gap = 20;
    };
  };
}
