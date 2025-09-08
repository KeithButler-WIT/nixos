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
      xserver = {
        enable = true;
        displayManager.sddm.enable = true;
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
