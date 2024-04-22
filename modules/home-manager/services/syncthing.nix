{ pkgs, config, lib, ... }:

{

  options = {
    modules.services.syncthing.enable =
      lib.mkEnableOption "enables syncthing";
  };

  config = lib.mkIf config.modules.services.syncthing.enable {
    services.syncthing = {
      enable = true;
      # openDefaultPorts = true;
    };
    # services.syncthing.tray.enable = true;
  };

}
