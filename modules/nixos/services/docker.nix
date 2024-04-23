{ pkgs, config, lib, ... }:

with lib;
let cfg = config.modules.services.docker;
in {

  options.modules.services.docker.enable =
    mkEnableOption "enables docker";

  config = mkIf cfg.enable {
    virtualisation.docker.enable = true;

    environment.systemPackages = with pkgs; [
      distrobox
      docker
    ];

  };

}