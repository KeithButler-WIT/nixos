{
  pkgs,
  config,
  lib,
  userSettings,
  ...
}:

with lib;
with lib.my;
let
  cfg = config.modules.services.printer;
in
{

  options.modules.services.printer.enable = mkBoolOpt false;

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
    users.users.${userSettings.username}.extraGroups = [
      "scanner"
      "lp"
    ];
  };

}
