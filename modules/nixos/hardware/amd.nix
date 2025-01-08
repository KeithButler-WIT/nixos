{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.my;
let
  cfg = config.modules.hardware.amd;
in
{
  options.modules.hardware.amd.enable = mkBoolOpt false;

  config = mkIf cfg.enable {
    boot.initrd.kernelModules = [ "amdgpu" ];

    services.xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
    };
    hardware.graphics = {
      enable32Bit = true; # For 32 bit applications
      extraPackages = with pkgs; [
        #rocmPackages.clr.icd
        amdvlk
      ];
      # For 32 bit applications
      extraPackages32 = with pkgs; [
        driversi686Linux.amdvlk
      ];
    };
  };
}
