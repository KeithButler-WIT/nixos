{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.nh;
in {
  options.modules.nh.enable = mkBoolOpt false;

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      nh
      nix-output-monitor
      nvd
    ];

    home.sessionVariables = {
      NH_FLAKE = "$HOME/nixos";
    };
  };
}
