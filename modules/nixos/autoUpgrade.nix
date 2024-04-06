{ pkgs, config, lib, ... }:

{

  options = {
    autoUpgrade.enable =
      lib.mkEnableOption "enables autoUpgrade";
  };

  config = lib.mkIf config.autoUpgrade.enable {
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
