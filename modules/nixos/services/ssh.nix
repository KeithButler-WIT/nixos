{ pkgs, config, lib, ... }:

with lib;
let cfg = config.modules.services.ssh;
in {

  options.modules.services.ssh.enable =
    mkEnableOption "enables ssh";

  config = mkIf cfg.enable {
    # Enable the OpenSSH daemon.
    services.openssh.enable = true;
  };

}
