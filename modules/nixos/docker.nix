{ pkgs, config, lib, ... }:

{

  options = {
    docker.enable =
      lib.mkEnableOption "enables docker";
  };

  config = lib.mkIf config.docker.enable {
    virtualisation.docker.enable = true;
    
    environment.systemPackages = with pkgs; [
      distrobox
      docker
    ];

  };

}
