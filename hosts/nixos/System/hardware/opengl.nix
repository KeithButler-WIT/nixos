{ config, pkgs, lib, inputs, ... }:

{

  # TODO: Maybe remove this
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
