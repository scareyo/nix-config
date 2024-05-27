{ config, inputs, lib, pkgs, ... }:

{
  imports = [
    inputs.nix-virt.nixosModules.default
  ];

  options = with lib; {
    system.nixos.vm.win11.enable = mkEnableOption "Enable Windows virtual machine";
    system.nixos.vm.win11.config = mkOption {
      type = types.path;
      description = "Path to libvirt config";
    };
  };

  config = lib.mkIf config.system.nixos.vm.win11.enable {
    programs.virt-manager.enable = true;

    virtualisation.libvirtd = {
      qemu = {
        swtpm.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };

    virtualisation.libvirt = {
      enable = true;
      connections."qemu:///system" = with inputs.nix-virt.lib; {
        domains = [
          {
            definition = config.system.nixos.vm.win11.config;
          }
        ];
      };
    };

    # Scream Audio Receiver
    nixpkgs.config.packageOverrides = pkgs: {
      scream = pkgs.scream.override {
        pcapSupport = true;
      };
    };

    security.wrappers = {
      scream = {
        owner = "root";
        group = "root";
        capabilities = "cap_net_raw,cap_net_admin=eip";
        source = "${pkgs.scream.out}/bin/scream";
      };
    };

    systemd.user.services.scream = {
      description = "Scream audio receiver";
      wantedBy = [ "default.target" ];
      serviceConfig = {
        ExecStart = ''/run/wrappers/bin/scream -o pulse -i virbr0 -P'';
      };
    };

    # Looking Glass Client
    environment.systemPackages = [
      pkgs.looking-glass-client
    ];

    systemd.tmpfiles.rules = [
      "f /dev/shm/looking-glass 0660 ${config.system.username} kvm -"
    ];
  };
}

