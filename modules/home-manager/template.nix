{ pkgs, config, lib, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.ssh;
in {

  options.modules.services.ssh.enable =
    mkEnableOption "enables ssh";

  config = mkIf cfg.enable { };

}
