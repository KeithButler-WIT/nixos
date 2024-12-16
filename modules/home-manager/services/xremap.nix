{ config, inputs, lib, pkgs, userSettings, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.xremap;
in {

  options.modules.services.xremap.enable =
    mkBoolOpt false;

  imports = [
    inputs.xremap-flake.homeManagerModules.default
  ];

  config = mkIf cfg.enable {
    # https://youtu.be/lyxScRCe6bE?si=0euSc6YtnGXxkPaf
    services.xremap = {
      enable = true;
      withHypr = true;
      watch = true;
      yamlConfig = ''
        modmap:
            - name: main remaps
                remap:
                    CapsLock:
                    held: CapsLock
                    alone: esc
                    alone_timeout_millis: 150
      '';
    };
  };

}
