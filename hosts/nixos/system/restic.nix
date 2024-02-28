{ config, pkgs, ... }:

{

  services.restic.backups = {
    home-backup = {
      user = "backups";
      repository = "/run/media/${userSettings.username}/4TB-BACKUP/backups";
      initialize = true; # initializes the repo, don't set if you want manual control
      passwordFile = "<path>";
      timerConfig = {
        onCalendar = "saturday 23:00";
      };
    };
  };

}
