{ pkgs, config, lib, inputs, ... }:

with lib;
let cfg = config.modules.autoUpgrade;
in {

  options.modules.autoUpgrade.enable =
    mkEnableOption "enables autoUpgrade";

  config = lib.mkIf cfg.enable {
    system.autoUpgrade = {
      enable = true;
      flake = inputs.self.outPath;
      flags = [
        "--update-input"
        "nixpkgs"
        "-L"
      ];
      dates = "09:00";
      randomizedDelaySec = "45min";
    };
  };

}
