{ lib, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    package = lib.mkIf pkgs.stdenv.isDarwin null;
    profiles.scarey = {
      isDefault = true;
      bookmarks = {};
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
        ublock-origin
      ];
    };
  };
}
