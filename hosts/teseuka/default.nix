{ lib, pkgs, ... }:

{
  imports = [ 
    ../../modules/system/nixos

    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  system = {
    username = "scarey";
    fullname = "Samuel Carey";
    nixos = {
      enable = true;
      gnome.enable = true;
    };
  };
  
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelModules = [
      "vfio_pci"
      "vfio"
      "vfio_iommu_type1"
      "vfio_virqfd"

      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"

      "i2c-dev"
    ];

    kernelParams = [
      "intel_iommu=on"
      "iommu=pt"
      "vfio-pci.ids=10de:2206,10de:1aef"
    ];

    extraModprobeConfig = lib.mkDefault ''
      blacklist nouveau
      options nouveau modeset=0
    '';

    blacklistedKernelModules = lib.mkDefault [ "nouveau" "nvidia" ];
  };

  networking.hostName = "teseuka";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
