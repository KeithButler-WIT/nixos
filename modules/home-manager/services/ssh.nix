{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.services.ssh;
in {

  options.modules.services.ssh.enable =
    mkEnableOption "enables ssh";

  config = mkIf cfg.enable {
    programs.ssh = {
      enable = true;
      matchBlocks."github.com" = {
        user = "git";
        identityFile = "~/.ssh/id_ed25519";
      };
      extraConfig = ''
    '';
    };
  };

}
