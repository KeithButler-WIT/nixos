{ pkgs, config, lib, ... }:

with lib;
let cfg = config.modules.desktop;
in {

  options.modules.desktop.enable =
    mkEnableOption "enables desktop";

  config = lib.mkIf cfg.enable { };

}
