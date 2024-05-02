{ pkgs, config, lib, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.ssh;
in {

  options.modules.services.ssh.enable =
    mkBoolOpt false;

  config = mkIf cfg.enable {
    # Enable the OpenSSH daemon.
    services.openssh.enable = true;
  };

}
