{ config, lib, pkgs, ... }:

{
  options = with lib; {
    system.username = mkOption {
      type = types.str;
      description = "Your username";
    };
    system.fullname = mkOption {
      type = types.str;
      description = "Your full name";
    };
  };

  config = {
    environment.systemPackages = with pkgs; [
      fastfetch
      home-manager
      just
    ];
  };
}
