{ inputs, pkgs, config, userSettings, ... }:

{

  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
    kate
    kwrited
    konsole
    kwalletmanager
    kwallet
    kmail
  ]
  ++
  [
    # pkgs.libsForQt5.plasma-browser-integration
    pkgs.libsForQt5.konsole
    pkgs.libsForQt5.oxygen
  ];

  # Enable tuigreet login manager
  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        # Auto Login
        command = "startplasma-wayland";
        # command = "Hyprland";
        user = userSettings.username;
      };
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --asterisks --user-menu --cmd Hyprland";
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
