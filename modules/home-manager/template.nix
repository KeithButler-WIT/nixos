{ pkgs, config, lib, ... }:

with lib;
with lib.my;
let cfg = config.modules.temp;
in {

  options.modules.temp.enable =
    mkBoolOpt false;

  config = mkIf cfg.enable { };

}
