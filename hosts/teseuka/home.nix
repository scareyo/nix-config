{ pkgs, ... }:

{
  imports = [
    ../../home/config/overlays.nix
    ../../home/config/packages.nix

    ../../home/config/firefox
    ../../home/config/git
    ../../home/config/gnome
    ../../home/config/kitty
    ../../home/config/nvim
    ../../home/config/zsh
  ];
  
  home.username = "scarey"; 
  home.homeDirectory = "/home/scarey";

  nixpkgs.config.allowUnfree = true;
  
  home.packages = with pkgs; [
    obsidian
    prismlauncher
    vesktop
  ];

  scarey.home.git = {
    enable = true;
    name = "Samuel Carey";
    email = "sam@scarey.me";
  };

  home.stateVersion = "23.11";
}
