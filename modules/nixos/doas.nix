{ pkgs, config, lib, userSettings, ... }:

with lib;
with lib.my;
let cfg = config.modules.doas;
in {

  options.modules.doas.enable =
    mkBoolOpt false;

  config = lib.mkIf cfg.enable {
    security.doas.enable = true;
    security.sudo.enable = false;
    security.doas.extraRules = [{
      users = [ userSettings.username ]; # TODO: change to username
      # Optional, retains environment variables while running commands 
      # e.g. retains your NIX_PATH when applying your config
      keepEnv = true;
      persist = true; # Optional, only require password verification a single time
    }];
  };

}
