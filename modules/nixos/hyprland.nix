{ pkgs, config, lib, inputs, ... }:

{

  # imports = [
  #   ./autologin.nix
  #   ./tuigreet.nix
  # ];

  options = {
    hyprland.enable =
      lib.mkEnableOption "enables hyprland";
  };

  config = lib.mkIf config.hyprland.enable {
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

    tuigreet.enable = true;
    autologin.enable = true;
  };

}
