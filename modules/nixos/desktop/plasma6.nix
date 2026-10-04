{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.desktop.plasma6;
in {
  options.modules.desktop.plasma6.enable = mkBoolOpt false;

  config = lib.mkIf cfg.enable {
    services = {
      # displayManager.enable = false;
      # displayManager.plasma-login-manager.enable = false;
      displayManager.defaultSession = "plasma"; # TODO: make defaultSession an option shared between desktop environments
      xserver = {
        enable = true;
        displayManager.sddm.enable = false;
      };
      desktopManager.plasma6.enable = true;
    };
    environment.plasma6.excludePackages = with pkgs.kdePackages;
      [
        elisa
        kate
        kwrited
        konsole
        kwalletmanager
        kwallet
        kmail
      ]
      ++ [
      ];
  };
}
