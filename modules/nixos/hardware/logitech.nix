{ pkgs, config, lib, ... }:

with lib;
let cfg = config.modules.hardware.logitech;
in {

  options.modules.hardware.logitech.enable =
    mkEnableOption "enables logitech";


  config = lib.mkIf cfg.enable {
    hardware.logitech.wireless.enable = true;
    hardware.logitech.wireless.enableGraphical = true;
  };

}
