{ config, pkgs, lib, userSettings, ... }:

{

  # Detect printers
  services = {
    printing.enable = true;
    printing.drivers = [ pkgs.hplip ];
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    ipp-usb.enable = true;
  };
  # hardware.sane = {
  #   enable = true;
  #   extraBackends = [ pkgs.sane-airscan ];
  #   disabledDefaultBackends = [ "escl" ];
  # };
  programs.system-config-printer.enable = true;
  users.users.${userSettings.username}.extraGroups = [ "scanner" "lp" ];

}
