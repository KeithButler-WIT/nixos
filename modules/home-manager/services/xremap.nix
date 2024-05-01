{ config, inputs, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.xremap;
in {

  options.modules.services.xremap.enable =
    mkEnableOption "enables xremap";

  imports = [
    inputs.xremap-flake.homeManagerModules.default
  ];

  config = mkIf cfg.enable {

    # https://youtu.be/lyxScRCe6bE?si=0euSc6YtnGXxkPaf
    # https://github.com/emberian/evdev/blob/1d020f11b283b0648427a2844b6b980f1a268221/src/scancodes.rs#L26-L572
    services.xremap = {
      # enable = true;
      withWlroots = true;
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
