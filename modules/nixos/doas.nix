{
  config,
  lib,
  userSettings,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.doas;
in {
  options.modules.doas.enable = mkBoolOpt false;

  config = lib.mkIf cfg.enable {
    security = {
      doas.enable = true;
      sudo.enable = false;
      doas.extraRules = [
        {
          users = [userSettings.username];
          # Optional, retains environment variables while running commands
          # e.g. retains your NIX_PATH when applying your config
          keepEnv = true;
          persist = true; # Optional, only require password verification a single time
        }
      ];
    };
  };
}
