{ config, lib, pkgs, inputs, userSettings, ... }:

with lib.my;
{

  home.packages = with pkgs; [
    # TODO add to direnv in required projects
    # pkgs.python311
    (python311.withPackages (ps: with ps; [ types-beautifulsoup4 beautifulsoup4 ]))

    v4l-utils

    nsxiv

    vscode
    jetbrains-toolbox

    scrcpy
    rclone-browser
    xdotool

    bitwarden
    bitwarden-cli
  ];

  modules = {
    just.enable = true;
    nh.enable = true;
    torrent.enable = true;
    desktop = {
      hyprland.enable = true;
      # waybar.enable = true;
      browsers = {
        # firefox.enable = true;
        floorp.enable = true;
        qutebrowser.enable = true;
      };
      apps = {
        lf.enable = true;
        nemo.enable = true;
        # dolphin.enable = true;
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
      # file-managers = { lf.enable = true; nemo.enable = true; dolphin.enable = true; };
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
      vm.enable = true;
      gtk.enable = true;
    };
    editors = {
      emacs.enable = true;
      neovim.enable = true;
      # helix.enable = true;
    };
    shell = {
      bash.enable = true;
      fish.enable = true;
      nu.enable = true;
      fzf.enable = true;
      git.enable = true;
      starship.enable = true;
      tealdeer.enable = true;
      direnv.enable = true;
      eza.enable = true;
      zoxide.enable = true;
      thefuck.enable = true;
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
