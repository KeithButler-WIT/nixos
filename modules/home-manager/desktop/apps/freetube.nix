{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
with lib.my;
let
  cfg = config.modules.desktop.apps.freetube;
in
{

  options.modules.desktop.apps.freetube.enable = mkBoolOpt false;

  config = mkIf cfg.enable {
    programs.freetube = {
      enable = true;
      settings = {
        allowDashAv1Formats = true;
        checkForUpdates = false;
        defaultQuality = "1080";
        baseTheme = "catppuccinMocha";
      };
    };
  };

}
