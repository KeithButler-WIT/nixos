{
  lib,
  pkgs,
  ...
}:
with lib.my; {
  home.packages = with pkgs; [
    v4l-utils

    # TODO: Move to shell module
    nsxiv
    wiki-tui
    # rusty-man
    tokei
    ripgrep-all
    presenterm
    dust
    dua
    bacon
    cargo-info
    ncspot

    # TODO: Move to own module
    grayjay
    lmstudio
    openrgb
    mcontrolcenter
    nyx
    wiremix
    # impala # not my network manager
    bluetui
    discordo # Discord flagged the login
    lynx

    # vscode
    # jetbrains-toolbox

    scrcpy
    rclone-browser
    xdotool

    #TODO: remove
    ntlmrecon

    p7zip
    zenity
    winetricks

    libxkbcommon

    vintagestory

    # TODO: Move to niri module
    tofi
    xwayland-satellite
  ];

  programs.rclone.enable = true;

  modules = {
    # just.enable = true;
    nh.enable = true;
    gc.enable = true;
    torrent = {
      enable = true;
      # rtorrent.enable = true;
      qbit.enable = true;
    };
    tmux.enable = true;
    desktop = {
      hyprland = {
        enable = true;
        monitors = [
          {
            output = "eDP-1";
            position = "1920x1080@60";
            primary = true;
          }
          {
            output = "HDMI-A-1";
            mode = "1920x1080@60";
          }
        ];
      };
      browsers = {
        default = "zen";
        # firefox.enable = true;
        # floorp.enable = true;
        zen.enable = true; # TODO: Add zen module
        # qutebrowser.enable = true;
        # tor.enable = true;
        # chromium.enable = true;
      };
      apps = {
        bitwarden.enable = true;
        blender.enable = true;
        bottles.enable = true;
        # freetube.enable = true;
        godot.enable = true;
        gimp.enable = true;
        libreoffice.enable = true;
        pass.enable = true;
        signal.enable = true;
        # slack.enable = true;
        thunderbird.enable = true;
        unity = {
          enable = true;
          flatpak = true;
        };
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
        # ncmpcpp.enable = true;
      };
      term = {
        default = "kitty";
        kitty.enable = true;
        foot.enable = true;
        # alacritty.enable = true;
      };
      gtk.enable = true;
    };
    editors = {
      default = "nvim";
      alternate = "emacsclient";
      emacs.enable = true;
      # neovim.enable = true; # nvf in the nixos default.nix
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
      # thefuck.enable = true;
      pay-respects.enable = true;
    };
    services = {
      borgmatic.enable = true;
      dunst.enable = true;
      gpg.enable = true;
      # mako.enable = true;
      # mpd.enable = true;
      ssh.enable = true;
      syncthing.enable = true;
      # xremap.enable = true;
    };
  };

  programs.java.enable = true;

  services.home-manager.autoUpgrade.frequency = "monthly";
}
