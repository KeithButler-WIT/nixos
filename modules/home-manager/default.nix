{ pkgs, lib, ... }:

{
  imports = [
    ./firefox.nix
    ./lf.nix
  ];

  firefox.enable = lib.mkDefault false;
  lf.enable = lib.mkDefault false;

}
