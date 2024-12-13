{ pkgs, config, lib, userSettings, ... }:

with lib;
with lib.my;
let devCfg = config.modules.dev;
    cfg = devCfg.rust;
in {

  options.modules.dev.rust = {
    enable = mkBoolOpt false;
    xdg.enable = mkBoolOpt devCfg.xdg.enable;
  };

  config = mkMerge [
    (mkIf cfg.enable {
      users.users.${userSettings.username}.packages = with pkgs; [
        rustup
      ];
      environment.shellAliases = {
        rs  = "rustc";
        rsp = "rustup";
        ca  = "cargo";
      };
    })

    (mkIf cfg.xdg.enable {
      environment.variables = rec {
        RUSTUP_HOME = "$XDG_DATA_HOME/rustup";
        CARGO_HOME = "$XDG_DATA_HOME/cargo";
        PATH = [ "${CARGO_HOME}/bin" ];
      };
    })

  ];

}
