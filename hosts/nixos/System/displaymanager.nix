{ inputs, pkgs, config, userSettings, ... }:

{

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable tuigreet login manager
  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        # Auto Login
        # command = "startplasma-wayland";
        command = "Hyprland";
        user = userSettings.username;
      };
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --asterisks --user-menu --cmd Hyprland -s ${config.services.xserver.displayManager.sessionData.desktops}";
        user = "greeter";
      };
    };
  };

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

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin = {
    enable = true;
    user = userSettings.username;
  };

  services.getty.autologinUser = userSettings.username;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

}
