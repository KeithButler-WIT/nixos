{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
with lib.my;
let
  cfg = config.modules.desktop.apps.weeb;
in
{

  options.modules.desktop.apps.weeb.enable = mkBoolOpt false;

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ani-cli
      # mangal
      suwayomi-server
    ];
  };

}
