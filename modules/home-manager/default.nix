{ pkgs, lib, ... }:

{
  imports = [
    ./file
    ./browsers/firefox
    ./browsers/qutebrowser
    ./editors/emacs
    ./editors/neovim
    ./gaming/discord.nix
    ./media/mpv.nix
    ./media/ncmpcpp.nix
    ./hyprland
    ./services/borgmatic.nix
    ./services/dunst.nix
    ./services/mako.nix
    ./services/mpd.nix
    ./services/ssh.nix
    ./services/syncthing.nix
    ./services/xremap.nix
    ./shell/aliases
    ./shell/bash
    ./shell/fish
    ./shell/fzf
    ./shell/sessionVariables
    ./shell/git
    ./shell/starship
    ./shell/tealdeer
    ./term/alacritty.nix
    ./term/kitty.nix
    ./vm
    ./gtk.nix
    ./direnv.nix
    ./lf
    ./torrent.nix
    ./services/syncthing.nix
    ./nh.nix
    ./xdg.nix
  ];


  modules = {
    lf.enable = lib.mkDefault false;
    torrent.enable = lib.mkDefault false;
    nh.enable = lib.mkDefault true;
    direnv.enable = lib.mkDefault true;
    gtk.enable = lib.mkDefault true;
    hyprland.enable = lib.mkDefault false;
    browsers = {
      firefox.enable = lib.mkDefault false;
      qutebrowser.enable = lib.mkDefault false;
    };
    editors = {
      emacs.enable = lib.mkDefault false;
      neovim.enable = lib.mkDefault false;
    };
    gaming = { discord.enable = lib.mkDefault false; };
    media = {
      mpv.enable = lib.mkDefault true;
      ncmpcpp.enable = lib.mkDefault false;
    };
    shell = {
      bash.enable = lib.mkDefault true;
      fish.enable = lib.mkDefault true;
      fzf.enable = lib.mkDefault true;
      git.enable = lib.mkDefault true;
      starship.enable = lib.mkDefault true;
      tealdeer.enable = lib.mkDefault true;
    };
    term = {
      kitty.enable = lib.mkDefault false;
      alacritty.enable = lib.mkDefault false;
    };
    services = {
      borgmatic.enable = lib.mkDefault false;
      dunst.enable = lib.mkDefault false;
      mako.enable = lib.mkDefault false;
      mpd.enable = lib.mkDefault false;
      ssh.enable = lib.mkDefault true;
      syncthing.enable = lib.mkDefault true;
      xremap.enable = lib.mkDefault true;
    };
    vm.enable = lib.mkDefault false;
  };

}
