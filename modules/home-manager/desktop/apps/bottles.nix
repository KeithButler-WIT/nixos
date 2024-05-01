{ config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.apps.bottles;
in {

  options.modules.desktop.apps.bottles.enable =
    mkEnableOption "enables bottles";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      bottles
    ];
  };

}
