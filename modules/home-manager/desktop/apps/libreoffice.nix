{
  config,
  lib,
  pkgs,
  pkgs-stable,
  ...
}:

with lib;
with lib.my;
let
  cfg = config.modules.desktop.apps.libreoffice;
in
{

  options.modules.desktop.apps.libreoffice.enable = mkBoolOpt false;

  config = mkIf cfg.enable {
    home.packages = with pkgs-stable; [
      libreoffice
    ];
  };

}
