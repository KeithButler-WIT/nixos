{ config, lib, pkgs, inputs, userSettings, ... }:

with lib.my;
{

  home.packages = with pkgs; [
    # TODO add to direnv in required projects

    nixpkgs-fmt
    shfmt

    egl-wayland
    # pkgs.python311
    (python311.withPackages (ps: with ps; [ types-beautifulsoup4 beautifulsoup4 ]))

    toybox

    # TODO: Move into a flake in required folders
    # (pkgs.python310.withPackages (ps: with ps; [ pytz numpy types-beautifulsoup4 beautifulsoup4 requests black pyside6 pylint pillow pywlroots pyflakes poetry-core ]))

    v4l-utils

    termusic

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    nsxiv

    # pkgs.jetbrains.idea-ultimate
    # pkgs.jetbrains.idea-community
    # pkgs.jetbrains.clion
    # pkgs.jetbrains.rust-rover
    vscode
    # pkgs.android-studio

    scrcpy

    rclone-browser
    xdotool
  ];

  modules = {
    just.enable = true;
    nh.enable = true;
    # stylix.enable = true;
    hyprland.enable = true;
    torrent.enable = true;
    waybar.enable = true;
    desktop = {
      browsers = {
        # firefox.enable = true;
        floorp.enable = true;
        qutebrowser.enable = true;
      };
      apps = {
        lf.enable = true;
        blender.enable = true;
        bottles.enable = true;
        godot.enable = true;
        libreoffice.enable = true;
        obs.enable = true;
        pass.enable = true;
        signal.enable = true;
        slack.enable = true;
        thunderbird.enable = true;
        unity.enable = true;
        weeb.enable = true;
        # zoom.enable = true;
      };
      gaming = {
        discord.enable = true;
        minecraft.enable = true;
        r2modman.enable = true;
      };
      media = {
        mpv.enable = true;
        # ncmpcpp.enable = true;
      };
      term = {
        kitty.enable = true;
        # alacritty.enable = true;
      };
      # vm.enable = true;
      # gtk.enable = true;
    };
    editors = {
      emacs.enable = true;
      neovim.enable = true;
    };
    shell = {
      bash.enable = true;
      fish.enable = true;
      fzf.enable = true;
      git.enable = true;
      starship.enable = true;
      tealdeer.enable = true;
      direnv.enable = true;
    };
    services = {
      # borgmatic.enable = true;
      dunst.enable = true;
      # mako.enable = true;
      # mpd.enable = true;
      ssh.enable = true;
      syncthing.enable = true;
      xremap.enable = true;
    };
  };

  programs.java.enable = true;

  services.home-manager.autoUpgrade.frequency = "monthly";

}
