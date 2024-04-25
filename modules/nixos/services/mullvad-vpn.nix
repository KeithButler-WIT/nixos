{ pkgs, config, lib, ... }:

with lib;
let cfg = config.modules.services.mullvad-vpn;
in {

  options.modules.services.mullvad-vpn.enable =
    mkEnableOption "enables mullvad-vpn";

  config = lib.mkIf cfg.enable {
    services.mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };
  };

}
