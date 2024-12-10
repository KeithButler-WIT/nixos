{ pkgs, config, lib, inputs, ... }:

with lib;
with lib.my;
let cfg = config.modules.autoUpgrade;
in {

  options.modules.autoUpgrade.enable =
    mkBoolOpt false;

  config = lib.mkIf cfg.enable {
    system.autoUpgrade = {
      enable = true;
      flake = inputs.self.outPath;
      flags = [
        "--update-input"
        "nixpkgs"
        "--commit-lock-file"
      ];
      dates = "daily";
      randomizedDelaySec = "45min";
    };
  };

}
