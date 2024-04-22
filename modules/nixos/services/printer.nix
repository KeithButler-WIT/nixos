{ pkgs, config, lib, userSettings, ... }:

with lib;
let cfg = config.modules.services.printer;
in {

  options.modules.services.printer.enable =
    mkEnableOption "enables printer";

  config = mkIf cfg.enable {
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
  };

}
