{ config, lib, pkgs, ... }:

{

  imports = [
    ./aliases
    ./bash
    #./borgmatic
    ./direnv
    ./emacs
    ./fish
    ./git
    ./nvim
    #./ncmpcpp
    ./sessionVariables
    ./ssh
    ./fzf
    ./starship
    ./tealdeer
    ./torrent
    ./xremap
  ];

  home.packages = [
  ];

}
