{ pkgs, lib, ... }:

{

  imports = [
    ./file
    ./xdg.nix
    ./shell/sessionVariables
    ./shell/aliases
  ];

}
