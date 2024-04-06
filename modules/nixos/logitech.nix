{ pkgs, config, lib, ... }:

{

  options = {
    logitech.enable =
      lib.mkEnableOption "enables logitech";
  };

  config = lib.mkIf config.logitech.enable {
    hardware.logitech.wireless.enable = true;
    hardware.logitech.wireless.enableGraphical = true;
  };

}
