{ pkgs, config, lib, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop;
in {

  options.modules.desktop.enable =
    mkBoolOpt false;

  config = lib.mkIf cfg.enable { };

}
