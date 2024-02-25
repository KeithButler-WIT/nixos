{ pkgs, config, userSettings, ... }:

{

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Enable tuigreet login manager
  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        # Auto Login
        command = "startplasma-wayland";
        # command = "Hyprland";
        user = "keith";
      };
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --asterisks --user-menu --cmd startplasma-wayland";
        user = "greeter";
      };
    };
  };

  programs.hyprland = {
    enable = true;
    # Use the flake
    # package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    # Whether to enable XWayland
    xwayland.enable = true;
  };

  # Enable automatic login for the user.
  # ervices.xserver.displayManager.startx.enable = true;
  services.xserver.displayManager.autoLogin = {
    enable = true;
    user = userSettings.username;
  };

  services.getty.autologinUser = userSettings.username;
  # services.kmscon = {
  #   enable = true;
  #   autologinUser = userSettings.username;
  #   hwRender = true;
  # };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

}
