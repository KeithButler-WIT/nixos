{ pkgs, lib, ... }:

{
  imports = [
    ./lf.nix
  ];

  lf.enable = lib.mkDefault false;

}
