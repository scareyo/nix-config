{ config, lib, pkgs, ... }:

{
  options = with lib; {
    scarey.home.git.enable = mkEnableOption "git";
    scarey.home.git.name = mkOption {
      type = types.str;
      description = "git user.name config";
    };
    scarey.home.git.email = mkOption {
      type = types.str;
      description = "git user.email config";
    };
  };

  config = lib.mkIf config.scarey.home.git.enable {
    programs.git = {
      enable = true;
      userName = config.scarey.home.git.name;
      userEmail = config.scarey.home.git.email;
      signing = {
        key = null;
        signByDefault = true;
      };
      extraConfig = {
        diff.tool = "nvimdiff";
      };
    };
  
    programs.gpg.enable = true;
  
    services.gpg-agent = lib.mkIf pkgs.stdenv.isLinux {
      enable = true;
      enableZshIntegration = true;
      pinentryPackage = pkgs.pinentry-gnome3;
    };
  };
}
