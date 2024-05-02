{ pkgs, config, lib, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.firewall;
in {

  options.modules.services.firewall.enable =
    mkBoolOpt false;

  config = lib.mkIf cfg.enable {
    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    networking.firewall.enable = true;
  };

}
