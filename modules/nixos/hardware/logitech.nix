{
  config,
  lib,
  ...
}:
with lib;
with lib.my;
let
  cfg = config.modules.hardware.logitech;
in
{
  options.modules.hardware.logitech.enable = mkBoolOpt false;

  config = lib.mkIf cfg.enable {
    hardware.logitech.wireless.enable = true;
    hardware.logitech.wireless.enableGraphical = true;
  };
}
