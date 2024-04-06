{ pkgs, config, lib, userSettings, ... }:

{

  options = {
    tuigreet.enable =
      lib.mkEnableOption "enables tuigreet";
  };

  config = lib.mkIf config.tuigreet.enable {
    # Enable tuigreet login manager
    services.greetd = {
      enable = true;
      settings = {
        initial_session = lib.mkIf config.autologin.enable {
          # Auto Login
          # command = "startplasma-wayland";
          command = "Hyprland"; # TODO: change depending on enabled window manager
          user = userSettings.username;
        };
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --asterisks --user-menu --cmd Hyprland -s ${config.services.xserver.displayManager.sessionData.desktops}";
          user = "greeter";
        };
      };
    };
  };

}
