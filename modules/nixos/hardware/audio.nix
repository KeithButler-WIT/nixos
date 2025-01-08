{
  config,
  lib,
  inputs,
  userSettings,
  ...
}:
with lib;
with lib.my;
let
  cfg = config.modules.hardware.audio;
in
{
  options.modules.hardware.audio.enable = mkBoolOpt false;

  imports = [
    inputs.nix-gaming.nixosModules.pipewireLowLatency
  ];

  config = mkIf cfg.enable {
    # Enable sound with pipewire.
    #sound.enable = true;
    hardware.pulseaudio.enable = false;
    # make pipewire realtime-capable
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)1
      # media-session.enable = true;

      lowLatency = {
        # enable this module
        enable = false;
        # defaults (no need to be set unless modified)
        # quantum = 64;
        # rate = 48000;
        # rate = 192000;
        # quantum = 512;
        # min-quantum = 32;
        # max-quantum = 4096;
      };
    };

    users.users.${userSettings.username}.extraGroups = [ "audio" ];
  };
}
