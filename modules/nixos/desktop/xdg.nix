{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.my;
let
  cfg = config.modules.desktop.xdg;
in
{
  options.modules.desktop.xdg.enable = mkBoolOpt false;

  config = lib.mkIf cfg.enable {
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      xdgOpenUsePortal = true;
      config = {
        common.default = [ "gtk" ];
        hyprland.default = [
          "gtk"
          "hyprland"
        ];
      };
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
        xdg-desktop-portal
        xdg-desktop-portal-gnome # for niri
      ];
    };
  };
}
