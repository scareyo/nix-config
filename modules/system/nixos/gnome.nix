{ config, lib, ... }:

{
  options = with lib; {
    system.nixos.gnome.enable = mkEnableOption "Enable GNOME";
  };

  config = lib.mkIf config.system.nixos.gnome.enable {
    services.xserver = {
      enable = true;

      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    programs.dconf.enable = true;
  };
}
