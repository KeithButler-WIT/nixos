{
  pkgs,
  config,
  lib,
  userSettings,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.desktop.tuigreet;
in {
  options.modules.desktop.tuigreet.enable = mkBoolOpt false;

  config = lib.mkIf cfg.enable {
    # Enable tuigreet login manager
    services.greetd = {
      enable = true;
      settings = {
        initial_session = lib.mkIf config.modules.autologin.enable {
          # Auto Login
          # command = "startplasma-wayland";
          command = lib.mkIf config.modules.desktop.hyprland.enable "dbus-run-session Hyprland";
          user = userSettings.username;
        };
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --asterisks --user-menu --cmd Hyprland";
          # command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --asterisks --user-menu --cmd Hyprland -s ${config.services.xserver.displayManager.sessionData.desktops}";
          user = "greeter";
        };
      };
    };
  };
}
