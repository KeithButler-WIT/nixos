{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.desktop.cosmic;
in {
  options.modules.desktop.cosmic.enable = mkBoolOpt false;

  config = lib.mkIf cfg.enable {
    services.desktopManager.cosmic.enable = true;
  };
}
