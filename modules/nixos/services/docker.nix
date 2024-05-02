{ pkgs, config, lib, userSettings, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.docker;
in {

  options.modules.services.docker.enable =
    mkBoolOpt false;

  config = mkIf cfg.enable {
    virtualisation.docker.enable = true;

    environment.systemPackages = with pkgs; [
      distrobox
      docker
    ];

    users.users.${userSettings.username}.extraGroups = [ "docker" ];

  };

}
