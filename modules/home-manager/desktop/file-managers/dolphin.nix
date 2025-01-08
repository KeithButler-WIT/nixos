{
  pkgs,
  config,
  lib,
  ...
}:

with lib;
with lib.my;
let
  cfg = config.modules.desktop.file-managers.dolphin;
in
{

  #TODO: Fix module path
  options.modules.desktop.file-managers.dolphin.enable = mkBoolOpt false;

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      kdePackages.dolphin
    ];
  };

}
