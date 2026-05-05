{
  config,
  lib,
  pkgs-stable,
  ...
}:

with lib;
with lib.my;
let
  cfg = config.modules.desktop.apps.bottles;
in
{

  options.modules.desktop.apps.bottles.enable = mkBoolOpt false;

  config = mkIf cfg.enable {
    home.packages = with pkgs-stable; [
      bottles
    ];
  };

}
