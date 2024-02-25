{ config, pkgs, lib, userSettings, ... }:

lib.mkIf ("${userSettings.gpuType}" == "amd") {

  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.opengl = {
    driSupport = true; # This is already enabled by default
    driSupport32Bit = true; # For 32 bit applications
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
      amdvlk
    ];
    # For 32 bit applications 
    extraPackages32 = with pkgs; [
      driversi686Linux.amdvlk
    ];
  };

}
