{ config, lib, ... }:

{
  imports = [ 
    ../common
    ./dock.nix
  ];

  options = with lib; {
    system.darwin.enable = mkEnableOption "Enable darwin system configuration";
  };

  config = lib.mkIf config.system.darwin.enable {
    nix.settings.experimental-features = "nix-command flakes";

    # Set host platform
    nixpkgs.hostPlatform = "aarch64-darwin";
  
    nixpkgs.config.allowUnfree = true;
    services.nix-daemon.enable = true;
    programs.zsh.enable = true;

    users.users.${config.system.username} = {
      name = config.darwin.username;
      home = "/Users/${config.system.username}";
    };

    # Copying applications so they appear in spotlight
    # Upstream issue: https://github.com/LnL7/nix-darwin/issues/214
    system.activationScripts.applications.text = lib.mkForce ''
      echo "Copying applications" >&2
      nix_apps="/Applications/Nix Apps"

      # Delete the directory to remove old links
      rm -rf "$nix_apps"
      mkdir -p "$nix_apps"

      find ${config.system.build.applications}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
          while read src; do
              echo "Copying $src to $nix_apps" >&2
              cp -r "$src" "$nix_apps/"
          done
    '';
  };
}
