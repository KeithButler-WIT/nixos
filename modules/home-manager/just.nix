{
  pkgs,
  config,
  lib,
  ...
}:

with lib;
with lib.my;
let
  cfg = config.modules.just;
in
{

  options.modules.just.enable = mkBoolOpt false;

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      just
      ripgrep
    ];

    # vpn-connected := if mullvad status

    # home.file."justfile" = ""
    #   default:
    #     @just - -list

    #   torrent:
    #     mullvad connect
    #     sudo zpool import zfs-1TB-BACKUP
    #     rtorrent
    #     flood
    # "";
  };

}
