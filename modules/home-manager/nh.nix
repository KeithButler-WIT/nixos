{ pkgs, config, lib, ... }:

with lib;
let cfg = config.modules.nh;
in {

  options.modules.nh.enable =
    mkEnableOption "enables nh";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      nh
      nix-output-monitor
      nvd
    ];

    home.sessionVariables = {
      FLAKE = "$HOME/nixos";
    };
  };

}
