{
  config,
  lib,
  ...
}:
with lib;
with lib.my;
let
  cfg = config.modules.services.flood;
in
{
  options.modules.services.flood.enable = mkBoolOpt false;

  config = mkIf cfg.enable {
    services.flood = {
      enable = true;
      openFirewall = true;
      host = "10.149.82.212";
      #extraArgs = ["-h 10.149.82.212"];
    };
  };
}
