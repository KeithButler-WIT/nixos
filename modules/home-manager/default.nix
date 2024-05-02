{ pkgs, lib, ... }:

with lib.my;
{

  imports = [
    ./file
    ./xdg.nix
    ./shell/sessionVariables
    ./shell/aliases
  ];

}
