{
  pkgs,
  config,
  lib,
  ...
}:

with lib;
with lib.my;
let
  cfg = config.modules.services.mpd;
in
{

  options.modules.services.mpd.enable = mkBoolOpt false;

  config = mkIf cfg.enable {
    services.mpd = {
      enable = true;
      musicDirectory = "~/Music";
    };
  };

}
