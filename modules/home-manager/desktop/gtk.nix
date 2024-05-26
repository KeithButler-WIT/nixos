{ config, lib, pkgs, userSettings, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.gtk;
in {

  options.modules.desktop.gtk.enable =
    mkBoolOpt false;

  config = mkIf cfg.enable {
    fonts.fontconfig.enable = true;
    home.packages = [
      pkgs.nerdfonts
      (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      pkgs.twemoji-color-font
      pkgs.noto-fonts-emoji
    ];

    qt = {
      enable = true;
      # style = {
      # name = "adwaita-dark";
      # package = pkgs.adwaita-qt;
      # };
    };

    gtk = {
      enable = true;
      # theme = {
      #   name = "Catppuccin-Mocha-Standard-Blue-Dark";
      #   package = pkgs.catppuccin-gtk;
      # };
      # theme = {
      #   name = "Catppuccin-Mocha-Compact-Lavender-Dark";
      #   package = pkgs.catppuccin-gtk.override {
      #     accents = [ "lavender" ];
      #     size = "compact";
      #     # tweaks = [ "rimless" ];
      #     variant = "mocha";
      #   };
      # };
      # # iconTheme = {
      # #   name = "Tela-pink-dark";
      # #   package = pkgs.tela-icon-theme;
      # # };
      # iconTheme = {
      #   name = "Papirus-Dark";
      #   package = pkgs.catppuccin-papirus-folders.override {
      #     flavor = "mocha";
      #     accent = "lavender";
      #   };
      # };
      # # cursorTheme = {
      # #   name = "Dracula-cursors";
      # #   package = pkgs.dracula-icon-theme;
      # #   size = 11;
      # # };
      # cursorTheme = {
      #   name = "Nordzy-cursors";
      #   package = pkgs.nordzy-cursor-theme;
      #   size = 22;
      # };
      # # font = {
      # #   name = "Fantasque Sans Mono";
      # #   package = pkgs.fantasque-sans-mono;
      # #   size = 11;
      # # };
      # font = {
      #   name = "JetBrainsMono Nerd Font";
      #   size = 11;
      # };
    };
  };

}
