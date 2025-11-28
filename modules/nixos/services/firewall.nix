{
  config,
  lib,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.services.firewall;
in {
  options.modules.services.firewall.enable = mkBoolOpt false;

  config = lib.mkIf cfg.enable {
    # Open ports in the firewall.
    networking.firewall.allowedTCPPorts = [27036 42805 4549];
    networking.firewall.allowedTCPPortRanges = [
      {
        from = 27015;
        to = 27016;
      }
      {
        from = 42852;
        to = 42872;
      }
    ];
    networking.firewall.allowedUDPPorts = [42805 4175 4179 4171 4549];
    networking.firewall.allowedUDPPortRanges = [
      {
        from = 27015;
        to = 27016;
      }
      {
        from = 27031;
        to = 27036;
      }
      {
        from = 42852;
        to = 42872;
      }
    ];
    networking.firewall.enable = true;
  };
}
