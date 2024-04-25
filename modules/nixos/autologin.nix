{ pkgs, config, lib, userSettings, ... }:

with lib;
let cfg = config.modules.autologin;
in {

  options.modules.autologin.enable =
    mkEnableOption "enables autologin";

  config = lib.mkIf cfg.enable {
    # Enable automatic login for the user.
    services.displayManager.autoLogin = {
      enable = true;
      user = userSettings.username;
    };

    services.getty.autologinUser = userSettings.username;

  };

}
