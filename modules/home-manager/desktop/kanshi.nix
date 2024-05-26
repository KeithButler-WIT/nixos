{ config, lib, pkgs, inputs, userSettings, ... }:

with lib;
with lib.my;
let
  cfg = config.modules.desktop.kanshi;
in
{

  options.modules.desktop.kanshi.enable =
    mkBoolOpt false;

  config = mkIf cfg.enable {
    services.kanshi = {
      enable = true;
      systemdTarget = "hyprland-session.target";
      profiles = {
        docked = {
          outputs = [
            {
              criteria = "eDP-1";
              position = "0,1080";
              mode = "1920x1080@60Hz";
              status = "enable";
            }
            {
              criteria = "*";
              position = "0,0";
              mode = "1920x1080@60Hz";
              status = "enable";
            }
          ];
        };
        undocked = {
          outputs = [
            {
              criteria = "eDP-1";
              position = "0,0";
              mode = "1920x1080@60Hz";
              status = "enable";
            }
          ];
        };
      };
    };
  };

}
