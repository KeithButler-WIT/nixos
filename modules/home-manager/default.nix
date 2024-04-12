{ pkgs, lib, ... }:

{
  imports = [
    ./alacritty.nix
    ./firefox
    ./lf
    ./torrent.nix
  ];

  alacritty.enable = lib.mkDefault false;
  firefox.enable = lib.mkDefault false;
  lf.enable = lib.mkDefault false;
  torrent.enable = lib.mkDefault false;

}
