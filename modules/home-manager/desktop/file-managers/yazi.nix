{ pkgs, config, lib, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.apps.yazi;
in {

  #TODO: Fix module path
  options.modules.desktop.apps.yazi.enable =
    mkBoolOpt false;

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      ffmpegthumbnailer
      unar
      jq
      poppler
      fd
      ripgrep
      fzf
      zoxide
      wl-clipboard
    ];

    programs.yazi = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
    };
  };

}
