{ pkgs, config, lib, inputs, ... }:

with lib;
let cfg = config.modules.desktop.hyprland;
in {

  # imports = [
  #   ./autologin.nix
  #   ./tuigreet.nix
  # ];

  options.modules.desktop.hyprland.enable =
    mkEnableOption "enables hyprland";


  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      # Use the flake
      package = inputs.hyprland.packages."${pkgs.system}".hyprland;
      # Whether to enable XWayland
      xwayland.enable = true;
    };
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      xdgOpenUsePortal = true;
      extraPortals = [
        # pkgs.xdg-desktop-portal-hyprland
        # pkgs.xdg-desktop-portal-gtk
        # pkgs.xdg-desktop-portal
      ];
    };

    modules.desktop.tuigreet.enable = true;
    modules.autologin.enable = true;
  };

}
