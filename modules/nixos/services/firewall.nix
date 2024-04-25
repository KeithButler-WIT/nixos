{ pkgs, config, lib, ... }:

with lib;
let cfg = config.modules.services.firewall;
in {

  options.modules.services.firewall.enable =
    mkEnableOption "enables firewall";

  config = lib.mkIf cfg.enable {
    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    networking.firewall.enable = true;
  };

}
