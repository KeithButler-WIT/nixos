{
  pkgs,
  config,
  lib,
  userSettings,
  ...
}:

with lib;
with lib.my;
let
  cfg = config.modules.dev;
in
{

  options.modules.dev.xdg.enable = mkBoolOpt false;

  config = lib.mkIf cfg.xdg.enable {
    # TODO
  };

}
