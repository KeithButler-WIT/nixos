{ pkgs, config, lib, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.mullvad-vpn;
in {

  options.modules.services.mullvad-vpn.enable =
    mkBoolOpt false;

  config = lib.mkIf cfg.enable {
    services.mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };
  };

}
