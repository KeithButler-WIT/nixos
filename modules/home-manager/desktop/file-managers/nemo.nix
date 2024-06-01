{ pkgs, config, lib, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.apps.nemo;
in {

  #TODO: Fix module path
  options.modules.desktop.apps.nemo.enable =
    mkBoolOpt false;

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      cinnamon.nemo-with-extensions

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
