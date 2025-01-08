{
  config,
  lib,
  ...
}:
with lib;
with lib.my;
let
  cfg = config.modules.services.backup;
in
{
  options.modules.services.backup.enable = mkBoolOpt false;

  config = mkIf cfg.enable {
    # Enable the OpenSSH daemon.
    services.borgmatic.enable = true;
    services.borgbackup.jobs =
      let
        common-excludes = [
          # Largest cache dirs
          ".cache"
          "*/cache2" # firefox
          "*/Cache"
          ".config/Slack/logs"
          ".config/Code/CachedData"
          ".container-diff"
          ".npm/_cacache"
          # Work related dirs
          "*/node_modules"
          "*/bower_components"
          "*/_build"
          "*/.tox"
          "*/venv"
          "*/.venv"
        ];
        work-dirs = [
          "/home/keith/workspace"
        ];
        basicBorgJob = name: {
          encryption.mode = "none";
          environment.BORG_RSH = "ssh -o 'StrictHostKeyChecking=no' -i /home/keith/.ssh/id_ed25519";
          environment.BORG_UNKNOWN_UNENCRYPTED_REPO_ACCESS_IS_OK = "yes";
          extraCreateArgs = "--verbose --stats --checkpoint-interval 600";
          repo = "ssh://keith@localhost//run/media/keith/4TB-BACKUP/backup-keith/${name}";
          compression = "zstd,1";
          startAt = "daily";
          user = "keith";
        };
      in
      {
        home-keith = basicBorgJob "backups/station/home-keith" // rec {
          paths = "/home/keith";
          exclude =
            work-dirs
            ++ map (x: paths + "/" + x) (
              common-excludes
              ++ [
                "Downloads"
              ]
            );
        };
      };
  };
}
