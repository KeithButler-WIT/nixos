{
  config,
  lib,
  pkgs,
  userSettings,
  ...
}:

with lib;
with lib.my;
let
  cfg = config.modules.shell.nu;
in
{

  options.modules.shell.nu.enable = mkBoolOpt false;

  config = mkIf cfg.enable {
    programs.nushell = {
      enable = true;
      # functions = {
      #   gitignore = "${pkgs.curl}/bin/curl -sL https://www.gitignore.io/api/$argv";
      #   yy = ''
      #   '';
      # };

    };
  };

}
