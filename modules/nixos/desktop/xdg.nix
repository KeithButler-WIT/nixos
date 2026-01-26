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
    xdg.mime = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "zen.desktop";
        "image/png" = [
          "sxiv.desktop"
          "gimp.desktop"
        ];
        "video/*" = [
          "mpv.desktop"
          "vlc.desktop"
        ];
        "audio/*" = [
          "mpv.desktop"
          "vlc.desktop"
        ];
      };
    };
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
