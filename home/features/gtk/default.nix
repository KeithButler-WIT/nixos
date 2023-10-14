{ config, lib, pkgs, ... }:

{
  qt = {
    enable = true;
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Ant-Dracula";
      package = pkgs.dracula-theme;
    };
    iconTheme = {
      name = "Tela-pink-dark";
      package = pkgs.tela-icon-theme;
    };
    cursorTheme = {
      name = "Dracula-cursors";
      package = pkgs.dracula-icon-theme;
      size = 11;
    };
    font = {
      name = "Fantasque Sans Mono";
      package = pkgs.fantasque-sans-mono;
      size = 11;
    };
    gtk2.extraConfig = "
include '/home/keith/.gtkrc-2.0.mine'
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
      gtk-button-images=1;
      gtk-enable-event-sounds=1;
      gtk-enable-input-feedback-sounds=0;
      gtk-menu-images=1;
      # gtk-modules=canberra-gtk-module:gail:atk-bridge;
      # gtk-sound-theme-name=Smooth;
      # gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR;
      # gtk-toolbar-style=GTK_TOOLBAR_BOTH_HORIZ;
      gtk-xft-antialias=1;
      gtk-xft-hinting=1;
      # gtk-xft-hintstyle=hintmedium;
      # gtk-xft-rgba=none;
      # gtk-application-prefer-dark-theme=1;
    };
    gtk4.extraConfig = {
      # gtk-application-prefer-dark-theme=1;
    };
  };
}
