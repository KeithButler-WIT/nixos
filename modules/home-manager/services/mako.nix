{ pkgs, config, lib, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.mako;
in {

  options.modules.services.mako.enable =
    mkEnableOption "enables mako";

  config = mkIf cfg.enable {
    services.mako = with config.colorScheme.palette; {
      enable = true;
      backgroundColor = "#${base01}";
      borderColor = "#${base0E}";
      borderRadius = 5;
      borderSize = 2;
      textColor = "#${base04}";
      layer = "overlay";
    };
  };

}
