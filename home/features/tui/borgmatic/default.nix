{ config, lib, pkgs, userSettings, ... }:

{

  programs.borgmatic = {
    enable = true;
    backups = {
      personal = {
        location = {
          sourceDirectories = [ config.home.homeDirectory ];
          repositories = [ "/run/media/${userSettings.username}/4TB-BACKUP/backup" ];
          excludeHomeManagerSymlinks = true;
          # extraConfig = {
          # before_backup = "${pkgs.util-linux}/bin/findmnt /run/media/${userSettings.username}/4TB-BACKUP > /dev/null || exit 75";
          # };
        };
        consistency.checks = [
          {
            name = "repository";
            frequency = "2 weeks";
          }
          {
            name = "archives";
            frequency = "4 weeks";
          }
          {
            name = "data";
            frequency = "6 weeks";
          }
          {
            name = "extract";
            frequency = "6 weeks";
          }
        ];
        retention.keepWeekly = 3;
        # storage.encryptionPasscommand = "${pkgs.password-store}/bin/pass Root/borg-repo"
      };
    };
  };

  services.borgmatic = {
    enable = true;
    frequency = "weekly";
  };

}
