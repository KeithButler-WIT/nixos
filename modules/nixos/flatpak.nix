{ pkgs, config, lib, ... }:

with lib;
with lib.my;
let cfg = config.modules.flatpak;
in {

  options.modules.flatpak.enable =
    mkBoolOpt false;


  config = lib.mkIf cfg.enable {
    services.flatpak.enable = true;
    systemd.services.flatpak-repo = {
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.flatpak ];
      script = ''
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      '';
    };
  };

}
