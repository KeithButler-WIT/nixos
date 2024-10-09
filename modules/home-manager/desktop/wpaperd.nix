{ config, lib, pkgs, inputs, userSettings, ... }:

with lib;
with lib.my;
let
  cfg = config.modules.desktop.wpaperd;
in
{

  options.modules.desktop.wpaperd.enable =
    mkBoolOpt false;

  config = mkIf cfg.enable {
    programs.wpaperd = {
      enable = true;
      settings = {
        default = {
          # path = "/home/${userSettings.username}/Pictures/Wallpapers";
          path = "/home/${userSettings.username}/Pictures/Stålenhag";
          #path = "/home/${userSettings.username}/Pictures";
          duration = "1h";
        };
      };
    };
  };

}
