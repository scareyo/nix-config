{ config, lib, pkgs, ... }:

{
  imports = [ 
    ../common

    ./vm/win11.nix

    ./gnome.nix
  ];

  options = with lib; {
    system.nixos.enable = mkEnableOption "Enable nixos system configuration";
  };

  config = lib.mkIf config.system.nixos.enable {
    nix.settings.experimental-features = "nix-command flakes";

    # Set host platform
    nixpkgs.hostPlatform = "x86_64-linux";
  
    nixpkgs.config.allowUnfree = true;
    programs.git.enable = true;
    programs.zsh.enable = true;
  
    users.users.${config.system.username} = {
      isNormalUser = true;
      description = config.system.fullname;
      extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
      shell = pkgs.zsh;
    };
  
    time.timeZone = "America/New_York";
    i18n.defaultLocale = "en_US.UTF-8";

    hardware.opengl.enable = true;
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
