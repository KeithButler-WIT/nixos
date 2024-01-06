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

  home.packages = [
      pkgs.w3m
      pkgs.ripgrep
      pkgs.entr

      # System management
      pkgs.htop
      pkgs.btop

      pkgs.newsboat
      pkgs.killall
      pkgs.zip
      pkgs.unzip
      pkgs.light
      pkgs.pass
      pkgs.yt-dlp
      pkgs.feh
      pkgs.htop
      pkgs.wget
      pkgs.gnupg
      pkgs.trash-cli
      pkgs.ncdu # disk space management
  ];

}
