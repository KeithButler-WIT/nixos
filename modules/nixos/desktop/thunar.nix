{ pkgs, config, lib, ... }:

with lib;
let cfg = config.modules.desktop.thunar;
in {

  options.modules.desktop.thunar.enable =
    mkEnableOption "enables thunar";

  config = lib.mkIf cfg.enable {
    programs.xfconf.enable = true;
    programs.thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
    services.gvfs.enable = true; # Mount, trash, and other functionalities
    services.tumbler.enable = true; # Thumbnail support for images
    environment.systemPackages = with pkgs; [
      xfce.tumbler # images
      webp-pixbuf-loader # webp
      poppler # pdf
      ffmpegthumbnailer # video
      freetype # font
      libgsf # odf
      nufraw-thumbnailer # raw
      gnome.totem # video/audio
      evince # pdf
      gnome-epub-thumbnailer # epub/mobi
      # mcomix # cbr
      # folderpreview # folders
      f3d # 3d files

      archiver
    ];
  };

}
