{ config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.shell.bash;
in {

  options.modules.shell.bash.enable =
    mkBoolOpt false;

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.zoxide
      pkgs.curl
      pkgs.man
    ];

    programs.bash = {
      enable = true;

      historyIgnore = [
        "ls"
        "cd"
        "z"
        "zi"
        "exit"
      ];

      historySize = 10000;

      initExtra = ''
        ${pkgs.macchina}/bin/macchina -t Berylilum

        eval "$(${pkgs.zoxide}/bin/zoxide init bash)"
      '';

      shellAliases = { };
    };
  };

}
