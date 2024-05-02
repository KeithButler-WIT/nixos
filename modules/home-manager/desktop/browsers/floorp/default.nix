{ config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.browsers.floorp;
in {

  options.modules.desktop.browsers.floorp.enable =
    mkBoolOpt false;

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # pkgs.librewolf
      # pkgs.icecat
      floorp
      buku # browser indepenent bookmarks
      bukubrow
    ];
  };

}
