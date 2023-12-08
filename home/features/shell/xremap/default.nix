{ config, inputs, lib, pkgs, ... }:

{
  # https://youtu.be/lyxScRCe6bE?si=0euSc6YtnGXxkPaf
  # https://github.com/emberian/evdev/blob/1d020f11b283b0648427a2844b6b980f1a268221/src/scancodes.rs#L26-L572
  services.xremap = {
    # enable = true;
    withX11 = true;
    # withHypr = true;
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
}
