{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
with lib.my;
let
  cfg = config.modules.services.ssh;
in
{

  options.modules.services.ssh.enable = mkBoolOpt false;

  config = mkIf cfg.enable {
    programs.ssh = {
      enable = true;
      matchBlocks."github.com" = {
        user = "git";
        identityFile = "~/.ssh/id_ed25519";
      };
      extraConfig = '''';
    };
  };

}
