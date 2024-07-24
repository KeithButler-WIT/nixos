{ config, lib, pkgs, inputs, userSettings, ... }:

with lib;
with lib.my;
let
  cfg = config.modules.desktop.hyprpaper;
in
{

  options.modules.desktop.hyprpaper.enable =
    mkBoolOpt false;

  config = mkIf cfg.enable {

    # https://wiki.hyprland.org/Hypr-Ecosystem/hypridle/
    services.hyprpaper = {
      enable = true;
      settings = { };
    };

  };

}
