{
  config,
  lib,
  pkgs,
  inputs,
  userSettings,
  ...
}:

with lib.my;
{

  home.packages = with pkgs; [
    v4l-utils

    nsxiv
    wiki-tui

    # vscode
    # jetbrains-toolbox

    scrcpy
    rclone-browser
    xdotool
    freetube

    #TODO: remove
    ntlmrecon

    p7zip
    zenity
    winetricks

    libxkbcommon
  ];

  modules = {
    # just.enable = true;
    nh.enable = true;
    gc.enable = true;
    torrent.enable = true;
    tmux.enable = true;
    desktop = {
      hyprland.enable = true;
      browsers = {
        default = "floorp";
        # firefox.enable = true;
        floorp.enable = true;
        # qutebrowser.enable = true;
        # tor.enable = true;
        # chromium.enable = true;
      };
      apps = {
        bitwarden.enable = true;
        # blender.enable = true;
        # bottles.enable = true;
        freetube.enable = true;
        godot.enable = true;
        libreoffice.enable = true;
        pass.enable = true;
        signal.enable = true;
        # slack.enable = true;
        thunderbird.enable = true;
        # unity3d.enable = true;
        # ue.enable = true;
        weeb.enable = true;
        # zoom.enable = true;
        discord.enable = true;
        # prismlauncher.enable = true;
        r2modman.enable = true;
      };
      file-managers = {
        default = "yazi";
        yazi.enable = true;
        # lf.enable = true;
        # nemo.enable = true;
        # dolphin.enable = true;
      };
      media = {
        video = {
          enable = true;
          # capture.enable = true;
          # editor.enable = true;
          player.enable = true;
          tools.enable = true;
        };
        ncmpcpp.enable = true;
      };
      term = {
        kitty.enable = true;
        # alacritty.enable = true;
      };
      gtk.enable = true;
    };
    editors = {
      default = "nvim";
      alternate = "emacsclient";
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
      borgmatic.enable = true;
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
