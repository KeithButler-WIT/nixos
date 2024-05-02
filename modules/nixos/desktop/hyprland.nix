{ pkgs, config, lib, inputs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.hyprland;
in {

  # imports = [
  #   ./autologin.nix
  #   ./tuigreet.nix
  # ];

  options.modules.desktop.hyprland.enable =
    mkBoolOpt false;


  config = lib.mkIf cfg.enable {
    # programs.hyprland = {
    # enable = true;
    # Use the flake
    # package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    # Whether to enable XWayland
    #   xwayland.enable = true;
    # };
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
        xdg-desktop-portal
      ];
      config.common.default = "*";
    };

    # modules.desktop.tuigreet.enable = mkDefault true;
    # modules.autologin.enable = mkDefault true;
  };

}
