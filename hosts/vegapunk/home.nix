{ config, lib, pkgs, ... }:

{
  imports = [
    ../../home/config/packages.nix
    ../../home/config/git
    ../../home/config/kitty
    ../../home/config/nvim
    ../../home/config/zsh
  ];

  home.username = "scarey"; 
  home.homeDirectory = "/Users/scarey";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;
  
  home.packages = with pkgs; [
    discord
  ];

  scarey.home.git = {
    enable = true;
    name = "Samuel Carey";
    email = "sam@scarey.me";
  };

  home.activation = {
    rsync-home-manager-applications = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      rsyncArgs="--archive --checksum --chmod=-w --copy-unsafe-links --delete"
      apps_source="$genProfilePath/home-path/Applications"
      moniker="Nix Apps"
      app_target_base="${config.home.homeDirectory}/Applications"
      app_target="$app_target_base/$moniker"
      mkdir -p "$app_target"
      ${pkgs.rsync}/bin/rsync $rsyncArgs "$apps_source/" "$app_target"
    '';
  };

  home.stateVersion = "23.11";
}
