{
  pkgs,
  config,
  lib,
  userSettings,
  ...
}:
with lib;
with lib.my;
let
  devCfg = config.modules.dev;
  cfg = devCfg.cc;
in
{
  options.modules.dev.cc = {
    enable = mkBoolOpt false;
    xdg.enable = mkBoolOpt devCfg.xdg.enable;
  };

  config = mkMerge [
    (mkIf cfg.enable {
      users.users.${userSettings.username}.packages = with pkgs; [
        clang
        gcc
        bear
        cmake
        llvmPackages.libcxx

        # Respect XDG, damn it!
        (mkWrapper gdb ''
          wrapProgram "$out/bin/gdb" --add-flags '-q -x "$XDG_CONFIG_HOME/gdb/init"'
        '')
      ];
    })

    (mkIf cfg.xdg.enable {
      # TODO
    })
  ];
}
