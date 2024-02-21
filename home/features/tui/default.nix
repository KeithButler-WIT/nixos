{ config, lib, pkgs, ... }:

{

  imports = [
    ./aliases
    ./bash
    ./borgmatic
    ./direnv
    ./emacs
    ./fish
    ./git
    ./lf
    ./nvim
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
    #pkgs.gum
    pkgs.mermaid-cli
    #pkgs.docker

    #pkgs.conda

    pkgs.wallust # better pywal
    pkgs.cava
    pkgs.numlockx
    pkgs.w3m
    pkgs.ripgrep
    pkgs.entr

    # System management
    pkgs.htop
    pkgs.btop

    pkgs.killall
    pkgs.zip
    pkgs.unzip
    pkgs.light
    pkgs.pass
    pkgs.yt-dlp
    pkgs.feh
    pkgs.wget
    pkgs.gnupg
    pkgs.trash-cli
    pkgs.ncdu # disk space management

    pkgs.rsync
    pkgs.rclone
  ];

}
