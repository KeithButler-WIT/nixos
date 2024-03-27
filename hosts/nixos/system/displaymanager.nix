{ inputs, pkgs, config, userSettings, ... }:

{

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;
  # services.desktopManager.plasma6.enable = true;
  # environment.plasma6.excludePackages = with pkgs.kdePackages; [
  #   elisa
  #   kate
  #   kwrited
  #   konsole
  #   kwalletmanager
  #   kwallet
  #   kmail
  # ]
  # ++
  # [
  #   # pkgs.libsForQt5.plasma-browser-integration
  #   pkgs.libsForQt5.konsole
  #   pkgs.libsForQt5.oxygen
  # ];

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
