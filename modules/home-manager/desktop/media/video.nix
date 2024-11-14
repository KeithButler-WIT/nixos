{ config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.media.video;
in {

  options.modules.desktop.media.video = {
    enable = mkBoolOpt false;
    capture.enable = mkBoolOpt false;
    editor.enable = mkBoolOpt false;
    player.enable = mkBoolOpt true;
    tools.enable = mkBoolOpt true;
  };

  config = mkIf cfg.enable (mkMerge [
    (mkIf cfg.capture.enable {
      home.packages = with pkgs; [
        obs-studio # For streaming/recording footage
      ];
    })

    (mkIf cfg.editor.enable {
      home.packages = with pkgs; [
        davinci-resolve # For streaming/recording footage
      ];
    })

    (mkIf cfg.player.enable {
      programs.mpv = {
        enable = true;
        # package = pkgs.wrapMpv (pkgs.mpv-unwrapped.override { vapoursynthSupport = true; }) { youtubeSupport = true; };
        scripts = [ pkgs.mpvScripts.sponsorblock pkgs.mpvScripts.webtorrent-mpv-hook pkgs.mpvScripts.thumbfast pkgs.mpvScripts.mpris ];
        config = {
          #
          # Example mpv configuration file
          #
          # Warning:
          #
          # The commented example options usually do _not_ set the default values. Call
          # mpv with --list-options to see the default values for most options. There is
          # no builtin or example mpv.conf with all the defaults.
          #
          #
          # Configuration files are read system-wide from /usr/local/etc/mpv.conf
          # and per-user from ~/.config/mpv/mpv.conf, where per-user settings override
          # system-wide settings, all of which are overridden by the command line.
          #
          # Configuration file settings and the command line options use the same
          # underlying mechanisms. Most options can be put into the configuration file
          # by dropping the preceding '--'. See the man page for a complete list of
          # options.
          #
          # Lines starting with '#' are comments and are ignored.
          #
          # See the CONFIGURATION FILES section in the man page
          # for a detailed description of the syntax.
          #
          # Profiles should be placed at the bottom of the configuration file to ensure
          # that settings wanted as defaults are not restricted to specific profiles.

          ##################
          # video settings #
          ##################

          # Start in fullscreen mode by default.
          fs = "yes";

          # force starting with centered window
          #geometry=50%:50%

          # don't allow a new window to have a size larger than 90% of the screen size
          #autofit-larger=90%x90%

          # Do not close the window on exit.
          #keep-open=yes

          # Do not wait with showing the video window until it has loaded. (This will
          # resize the window once video is loaded. Also always shows a window with
          # audio.)
          #force-window=immediate

          # Disable the On Screen Controller (OSC).
          #osc=no

          # Keep the player window on top of all other windows.
          #ontop=yes

          # Specify high quality video rendering preset (for --vo=gpu only)
          # Can cause performance problems with some drivers and GPUs.
          #profile=gpu-hq

          # Force video to lock on the display's refresh rate, and change video and audio
          # speed to some degree to ensure synchronous playback - can cause problems
          # with some drivers and desktop environments.
          #video-sync=display-resample

          # Enable hardware decoding if available. Often, this does not work with all
          # video outputs, but should work well with default settings on most systems.
          # If performance or energy usage is an issue, forcing the vdpau or vaapi VOs
          # may or may not help.
          hwdec = "auto";
          #vo=gpu
          gpu-context = "wayland";
          ##################
          # audio settings #
          ##################

          # Specify default audio device. You can list devices with: --audio-device=help
          # The option takes the device string (the stuff between the '...').
          #audio-device=alsa/default

          # Do not filter audio to keep pitch when changing playback speed.
          #audio-pitch-correction=no

          # Output 5.1 audio natively, and upmix/downmix audio with a different format.
          #audio-channels=5.1
          # Disable any automatic remix, _if_ the audio output accepts the audio format.
          # of the currently played file. See caveats mentioned in the manpage.
          # (The default is "auto-safe", see manpage.)
          #audio-channels=auto
          volume-max = 250;
          ##################
          # other settings #
          ##################

          # Pretend to be a web browser. Might fix playback with some streaming sites,
          # but also will break with shoutcast streams.
          #user-agent="Mozilla/5.0"

          # cache settings
          #
          # Use 150MB input cache by default. The cache is enabled for network streams only.
          #cache-default=153600
          #
          # Use 150MB input cache for everything, even local files.
          #cache=153600
          #
          # Disable the behavior that the player will pause if the cache goes below a
          # certain fill size.
          #cache-pause=no
          #
          # Read ahead about 5 seconds of audio and video packets.
          #demuxer-readahead-secs=5.0
          #
          # Raise readahead from demuxer-readahead-secs to this value if a cache is active.
          #cache-secs=50.0

          # Display English subtitles if available.
          #slang=en

          # Play Finnish audio if available, fall back to English otherwise.
          #alang=fi,en

          # Change subtitle encoding. For Arabic subtitles use 'cp1256'.
          # If the file seems to be valid UTF-8, prefer UTF-8.
          # (You can add '+' in front of the codepage to force it.)
          #sub-codepage=cp1256

          # You can also include other configuration files.
          #include=/path/to/the/file/you/want/to/include

          ############
          # Profiles #
          ############

          # The options declared as part of profiles override global default settings,
          # but only take effect when the profile is active.

          # The following profile can be enabled on the command line with: --profile=eye-cancer

          #[eye-cancer]
          #sharpen=5

          #keepaspect=no
          # save-position-on-quit;
        };
      };
    })

    (mkIf cfg.tools.enable {
      home.packages = with pkgs; [
        # Tools for (en|de)coding.
        ffmpeg_6-full # ...in the CLI
        handbrake # ...for the GUI
      ];
    })

  ]);

}