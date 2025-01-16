{
  config,
  lib,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.services.gpg;
in {
  options.modules.services.gpg.enable = mkBoolOpt false;

  config = mkIf cfg.enable {
    programs.gpg = {
      enable = true;
      homedir = "${config.xdg.dataHome}/gnupg";
    };
    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
    };
  };
}
