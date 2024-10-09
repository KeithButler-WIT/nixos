{ pkgs, config, lib, userSettings, ... }:

with lib;
with lib.my;
let cfg = config.modules.sudo-rs;
in {

  options.modules.sudo-rs.enable =
    mkBoolOpt false;

  config = lib.mkIf cfg.enable {
    security.sudo.enable = false;
    security.sudo-rs = {
      enable = true;
      # execWheelOnly = true;
      # wheelNeedsPassword = true;
      # extraRules = [{
        # groups = [ "sudo" "wheel" ]; commands = [ "ALL" ];
      # }];
    };
  };

}
