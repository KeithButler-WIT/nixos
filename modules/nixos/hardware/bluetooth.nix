{ pkgs, config, lib, ... }:

with lib;
let cfg = config.modules.hardware.bluetooth;
in {

  options.modules.hardware.bluetooth.enable =
    mkEnableOption "enables bluetooth";

  config = lib.mkIf cfg.enable {
    hardware.bluetooth.enable = true; # enables support for Bluetooth
    hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
    services.blueman.enable = true;
  };

}
