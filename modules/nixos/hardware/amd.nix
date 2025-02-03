{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.hardware.amd;
in {
  options.modules.hardware.amd.enable = mkBoolOpt false;

  config = mkIf cfg.enable {
    boot.initrd.kernelModules = ["amdgpu"];

    services.xserver = {
      enable = true;
      videoDrivers = ["amdgpu"];
    };
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };
      amdgpu.amdvlk = {
        enable = true;
        support32Bit.enable = true;
      };
    };
  };
}
