{ config, lib, pkgs, ... }:

{

  imports = [
    ./aliases
    ./bash
    ./borgmatic
    ./direnv
    ./fish
    ./git
    ./lf
    ./nvim
    ./mpv
    ./ncmpcpp
    ./sessionVariables
    ./ssh
    ./fzf
    ./starship
    ./tealdeer
    ./torrent
    ./xremap
  ];

}
