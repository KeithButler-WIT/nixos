{ config, inputs, lib, pkgs, ... }:

{
  # https://youtu.be/lyxScRCe6bE?si=0euSc6YtnGXxkPaf
  services.xremap = {
    # enable = true;
    withX11 = true;
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
