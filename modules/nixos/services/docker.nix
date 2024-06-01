{ pkgs, config, lib, userSettings, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.docker;
in {

  options.modules.services.docker = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      distrobox
      # docker
      # docker-compose # start group of containers for dev
      dive # look into docker image layers
      podman-tui # status of containers in the terminal
      podman-compose # start group of containers for dev
    ];

    virtualisation.containers.enable = true;
    virtualisation = {
      podman = {
        enable = true;
        # Create a `docker` alias for podman, to use it as a drop-in replacement
        dockerCompat = true;
        # Required for containers under podman-compose to be able to talk to each other.
        defaultNetwork.settings.dns_enabled = true;
        autoPrune.enable = true;

      };
      # docker = {
      #   enable = true;
      #   rootless = {
      #     enable = true;
      #     setSocketVariable = true;
      #   };
      # };
    };

    users.users.${userSettings.username}.extraGroups = [ "docker" ];
  };

}
