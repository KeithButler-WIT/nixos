{
  config,
  lib,
  pkgs,
  inputs,
  userSettings,
  ...
}:

with lib;
with lib.my;
let
  cfg = config.modules.desktop.hyprpaper;
in
{

  options.modules.desktop.hyprpaper.enable = mkBoolOpt false;

  config = mkIf cfg.enable {

    # https://wiki.hyprland.org/Hypr-Ecosystem/hyprpaper/
    services.hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        splash = false;
        splash_offset = 2.0;

        preload = [ "/home/keith/Pictures/Stålenhag/tftfbig-22.jpg" ];

        wallpaper = [
          "HDMI-A-2,/home/keith/Pictures/Stålenhag/tftfbig-22.jpg"
          ",/home/keith/Pictures/Stålenhag/tftfbig-22.jpg"
        ];
      };
    };

  };

}
