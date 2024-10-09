{ pkgs, config, lib, ... }:

with lib;
with lib.my;
let cfg = config.modules.nh;
in {

  options.modules.nh.enable =
    mkBoolOpt false;

  config = mkIf cfg.enable {
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 7d --keep 1";
      # Set from environment variable FLAKE
      # flake = "/home/${userSettings.username}/nixos";
    };
  };

}
