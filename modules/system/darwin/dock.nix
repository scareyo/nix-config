{ config, lib, ... }:

{
  options = with lib; {
    system.darwin.dock.enable = mkEnableOption "Enable dock configuration";
    system.darwin.dock.apps = mkOption {
      type = types.nullOr (types.listOf (types.either types.path types.str));
      description = "An list of applications to add to the dock";
    };
  };

  config = lib.mkIf config.system.darwin.dock.enable {
    system.defaults.dock = {
      autohide = true;
      show-recents = false;
      persistent-apps = config.system.darwin.dock.apps;

      # Hot Corner - Top Left - Mission Control
      wvous-tl-corner = 2;
    };
  };
}
