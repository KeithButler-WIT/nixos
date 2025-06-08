{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.desktop.hyprland;
in {
  options.modules.desktop.hyprland.enable = mkBoolOpt false;

  config = lib.mkIf cfg.enable {
    #programs.hyprland = {
    #  enable = true;
    #  package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    #  xwayland.enable = true;
    #};
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      xdgOpenUsePortal = true;
      config = {
        common.default = ["gtk"];
        hyprland.default = [
          "gtk"
          "hyprland"
        ];
      };
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
        xdg-desktop-portal
      ];
    };
    programs.hyprland.withUWSM = true;

    programs.uwsm = {
      enable = true;
      waylandCompositors = {
        hyprland = {
          prettyName = "Hyprland";
          comment = "Hyprland compositor managed by UWSM";
          binPath = "/etc/profiles/per-user/keith/bin/hyprland";
        };
      };
    };

    # modules.desktop.tuigreet.enable = mkDefault true;
    # modules.autologin.enable = mkDefault true;
  };
}
