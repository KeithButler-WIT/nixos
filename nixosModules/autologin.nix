{ pkgs, config, lib, userSettings, ... }:

{

  options = {
    autologin.enable =
      lib.mkEnableOption "enables autologin";
  };

  config = lib.mkIf config.autologin.enable {
    # Enable automatic login for the user.
    services.xserver.displayManager.autoLogin = {
      enable = true;
      user = userSettings.username;
    };

    services.getty.autologinUser = userSettings.username;

  };

}
