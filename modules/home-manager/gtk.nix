{ config, lib, pkgs, userSettings, ... }:

with lib;
let cfg = config.modules.gtk;
in {

  options.modules.gtk.enable =
    mkEnableOption "enables gtk";

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
      theme = {
        name = "Catppuccin-Mocha-Compact-Lavender-Dark";
        package = pkgs.catppuccin-gtk.override {
          accents = [ "lavender" ];
          size = "compact";
          # tweaks = [ "rimless" ];
          variant = "mocha";
        };
      };
      # iconTheme = {
      #   name = "Tela-pink-dark";
      #   package = pkgs.tela-icon-theme;
      # };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.catppuccin-papirus-folders.override {
          flavor = "mocha";
          accent = "lavender";
        };
      };
      # cursorTheme = {
      #   name = "Dracula-cursors";
      #   package = pkgs.dracula-icon-theme;
      #   size = 11;
      # };
      cursorTheme = {
        name = "Nordzy-cursors";
        package = pkgs.nordzy-cursor-theme;
        size = 22;
      };
      # font = {
      #   name = "Fantasque Sans Mono";
      #   package = pkgs.fantasque-sans-mono;
      #   size = 11;
      # };
      font = {
        name = "JetBrainsMono Nerd Font";
        size = 11;
      };

      gtk2.extraConfig = "
      include '/home/${userSettings.username}/.gtkrc-2.0.mine'
      gtk-toolbar-style=GTK_TOOLBAR_BOTH_HORIZ
      gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
      gtk-button-images=1
      gtk-menu-images=1
      gtk-enable-event-sounds=1
      gtk-enable-input-feedback-sounds=0
      gtk-xft-antialias=1
      gtk-xft-hinting=1
      gtk-xft-hintstyle='hintmedium'
      gtk-xft-rgba='none'
      gtk-modules='canberra-gtk-module:gail:atk-bridge'
    ";
      gtk3.extraConfig = {
        gtk-button-images = 1;
        gtk-enable-event-sounds = 1;
        gtk-enable-input-feedback-sounds = 0;
        gtk-menu-images = 1;
        # gtk-modules=canberra-gtk-module:gail:atk-bridge;
        # gtk-sound-theme-name=Smooth;
        # gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR;
        # gtk-toolbar-style=GTK_TOOLBAR_BOTH_HORIZ;
        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        # gtk-xft-hintstyle=hintmedium;
        # gtk-xft-rgba=none;
        # gtk-application-prefer-dark-theme=1;
      };
      gtk4.extraConfig = {
        # gtk-application-prefer-dark-theme=1;
      };
    };

    home.pointerCursor = {
      name = "Nordzy-cursors";
      package = pkgs.nordzy-cursor-theme;
      size = 22;
    };
  };

}
