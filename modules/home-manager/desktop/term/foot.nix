{
  config,
  lib,
  ...
}:

with lib;
with lib.my;
let
  cfg = config.modules.desktop.term.foot;
in
{

  options.modules.desktop.term.foot.enable = mkBoolOpt false;

  config = mkIf cfg.enable {
    programs.foot = {
      enable = true;
      settings = {
        main = {
          term = "xterm-256color";
          dpi-aware = mkForce "yes";
        };

        mouse = {
          hide-when-typing = "yes";
        };
      };
    };
  };

}
