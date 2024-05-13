{ pkgs, ... }:

{
  imports = [ 
    ../../modules/system/darwin
  ];

  homebrew = {
    enable = true;
    casks = [
      "firefox"
      "mullvadvpn"
      "steam"
    ];
  };
  
  system = {
    username = "scarey";
    fullname = "Samuel Carey";
    darwin = {
      enable = true;
      dock = {
        enable = true;
        apps = [
          "/Applications/Firefox.app"
          "/Users/scarey/Applications/Nix Apps/kitty.app"
          "/System/Applications/Mail.app"
          "/Users/scarey/Applications/Nix Apps/Discord.app"
          "/Applications/Steam.app"
        ];
      };
    };
  };

  system.stateVersion = 4;
}

