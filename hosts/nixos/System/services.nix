{ pkgs, config, lib, userSettings, inputs, ... }:

{

  services.envfs.enable = true;

  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };

}
  
