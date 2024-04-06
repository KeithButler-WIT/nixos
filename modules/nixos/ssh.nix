{ pkgs, config, lib, ... }:

{

  options = {
    ssh.enable =
      lib.mkEnableOption "enables ssh";
  };

  config = lib.mkIf config.ssh.enable {
    # Enable the OpenSSH daemon.
    services.openssh.enable = true;
  };

}
