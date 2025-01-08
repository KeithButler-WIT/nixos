{
  config,
  lib,
  ...
}:
with lib;
with lib.my;
let
  cfg = config.modules.hardware.bluetooth;
in
{
  options.modules.hardware.bluetooth.enable = mkBoolOpt false;

  config = lib.mkIf cfg.enable {
    hardware.bluetooth.enable = true; # enables support for Bluetooth
    hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
    services.blueman.enable = true;
  };
}
