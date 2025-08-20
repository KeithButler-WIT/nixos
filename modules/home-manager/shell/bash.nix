{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.shell.bash;
in {
  options.modules.shell.bash.enable = mkBoolOpt false;

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.zoxide
      pkgs.curl
      pkgs.man
    ];

    programs.command-not-found.enable = false;

    programs.bash = {
      enable = true;

      # functions = {
      #   gitignore = "${pkgs.curl}/bin/curl -sL https://www.gitignore.io/api/$argv";
      #   yy = ''
      #     local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
      #     yazi "$@" --cwd-file="$tmp"
      #     if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
      #     cd -- "$cwd"
      #     fi
      #     rm -f -- "$tmp"
      #   '';
      # };

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

        source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
      '';

      shellAliases = {};
    };
  };
}
