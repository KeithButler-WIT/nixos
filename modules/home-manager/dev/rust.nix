{ pkgs, config, lib, ... }:

with lib;
with lib.my;
let cfg = config.modules.dev.rust;
in {

  options.modules.dev.rust.enable =
    mkBoolOpt false;

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      cargo
      rustc
    ];
  };

}
