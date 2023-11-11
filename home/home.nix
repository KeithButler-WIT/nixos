{ config, lib, pkgs, inputs, ... }:

{

  imports = [
    inputs.xremap-flake.homeManagerModules.default
    inputs.nix-colors.homeManagerModules.default
    ./features/alacritty
    ./features/dunst
    ./features/emacs
    ./features/firefox
    ./features/fish
    ./features/git
    ./features/nvim
    ./features/gtk
    # ./features/mako.nix
    ./features/mpv
    # ./features/qutebrowser.nix
    # ./features/spicetify.nix
    ./features/tealdeer
    ./features/torrent
    ./features/xremap
  ];

  #nix.settings.experimental-features = [ "nix-command" "flakes" ];
  #nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1u"
    "python-2.7.18.6"
    "nodejs-16.20.1"
    "nodejs-16.20.2"
  ];
  # nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
  #   "postman"
  # ];
  targets.genericLinux.enable = true; # Enable this on non nixos

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  # colorScheme = inputs.nix-colors.colorSchemes.onedark;
  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;
  # colorScheme = inputs.nix-colors.colorSchemes.dracula;
  # colorScheme = inputs.nix-colors.colorSchemes.nord;
  # colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;
  # colorScheme = inputs.nix-colors.colorSchemes.solarized;
  # colorScheme = inputs.nix-colors.colorSchemes.tango;
  # colorScheme = inputs.nix-colors.colorSchemes.nova;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "keith";
  home.homeDirectory = "/home/keith";
  home = {

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "23.05"; # Please read the comment before changing.

    # The home.packages option allows you to install Nix packages into your
    # environment.
    packages = [
      # TODO move to hyprland conf
      (pkgs.python3Packages.buildPythonPackage rec {
        pname = "pyprland";
        version = "1.4.1";
        src = pkgs.fetchPypi {
            inherit pname version;
            sha256 = "sha256-JRxUn4uibkl9tyOe68YuHuJKwtJS//Pmi16el5gL9n8=";
        };
        format = "pyproject";
        propagatedBuildInputs = with pkgs; [
            python3Packages.setuptools
            python3Packages.poetry-core
            poetry
        ];
        doCheck = false;
        })


      pkgs.amdvlk
      pkgs.mesa
      # pkgs.linuxKernel.packages.linux_zen.amdgpu-pro
      pkgs.egl-wayland
      pkgs.i3lock
      pkgs.xss-lock
      pkgs.mcfly
      pkgs.shfmt
      pkgs.go-sct
      # pkgs.caffeine

      # Core Packages
      pkgs.libglvnd
      pkgs.mesa.drivers
      pkgs.killall
      pkgs.zip
      pkgs.unzip
      pkgs.light
      pkgs.thunderbird
      pkgs.yt-dlp
      pkgs.keepassxc
      pkgs.pass
      pkgs.libreoffice
      pkgs.github-desktop
      pkgs.github-cli
      # pkgs.firefox
      # pkgs.librewolf
      # pkgs.icecat
      pkgs.gpodder
      pkgs.gparted
      pkgs.yt-dlp
      pkgs.tor-browser-bundle-bin
      pkgs.fzf
      pkgs.rsync
      pkgs.grsync
      pkgs.feh
      pkgs.htop
      pkgs.wget
      pkgs.gnupg
      pkgs.trash-cli
      pkgs.ncdu # disk space management

      # pkgs.borg

      # pkgs.hyprland
      # pkgs.swww
      # pkgs.waybar
      # pkgs.swaylock
      # pkgs.wlogout
      # pkgs.swayidle
      # pkgs.grim
      # pkgs.dunst

      pkgs.rclone
      pkgs.rclone-browser

      (pkgs.python310.withPackages(ps: with ps; [ types-beautifulsoup4 beautifulsoup4 requests black pyside6 pylint pillow pywlroots pyflakes poetry-core ]))

      #pkgs.mongodb
      #pkgs.mongodb-tools
      #pkgs.mongosh

      pkgs.dracula-theme
      pkgs.dracula-icon-theme
      #pkgs.catppuccin-gtk
      #pkgs.lxappearance

      #pkgs.virt-manager
      #pkgs.libvirt
      #pkgs.libvirt-glib
      pkgs.quickemu
      pkgs.quickgui

      #pkgs.steam
      #pkgs.steam-run
      #pkgs.steamPackages.steamcmd
      #pkgs.steam-tui
      #(pkgs.steam.override {
      #  withPrimus = true;
      #  withJava = true;
      #  extraPkgs = pkgs: [
      #    pkgs.mono pkgs.gtk3 pkgs.gtk3-x11 pkgs.libgdiplus pkgs.zlib pkgs.bumblebee pkgs.glxinfo
      #  ];
      #  nativeOnly = true; })
      #pkgs.lutris

      pkgs.obs-studio
      #pkgs.heroic
      pkgs.gamemode
      pkgs.protonup-ng
      pkgs.protonup-qt
      #pkgs.proton-ge
      pkgs.winetricks
      pkgs.protontricks
      #pkgs.wine-staging
      #pkgs.wine-osu
      #pkgs.wine-tkg
      # (pkgs.openmw.overrideAttrs (_: rec { dontWrapQtApps = false; }))
      # pkgs.openmw

      #pkgs.godot
      pkgs.aseprite
      pkgs.godot_4
      # pkgs.unityhub
      pkgs.blender

      pkgs.mullvad-vpn

      # Xorg
      pkgs.xdg-desktop-portal-gtk
      pkgs.xorg.libX11
      pkgs.xorg.libX11.dev
      pkgs.xorg.libxcb
      pkgs.xorg.libXft
      pkgs.xorg.libXinerama
	    pkgs.xorg.xinit
      pkgs.xorg.xinput

      pkgs.syncthing
      pkgs.syncthing-tray

      pkgs.gpodder
      pkgs.ani-cli
      pkgs.mangal
      #pkgs.tachidesk

      # pkgs.discord
      pkgs.betterdiscordctl
      pkgs.signal-desktop
      # pkgs.zoom-us
      # pkgs.slack

      pkgs.spotify
      pkgs.cava

      # pkgs.jetbrains.idea-ultimate
      # pkgs.jetbrains.idea-community
      # pkgs.jetbrains.clion
      # pkgs.jetbrains.rustrover
      pkgs.vscode

      # # It is sometimes useful to fine-tune packages, for example, by applying
      # # overrides. You can do that directly here, just don't forget the
      # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # # fonts?
      (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
    ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    file = {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      ".bashrc".source = ~/.dotfiles/.bashrc;
      ".bash_profile".source = ~/.dotfiles/.bash_profile;
      ".profile".source = ~/.dotfiles/.profile;
      ".dmenurc".source = ~/.dotfiles/.dmenurc;
      ".xinitrc".source = ~/.dotfiles/.xinitrc;

      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';

      ".config/rofi/config.rasi".text = ''
        configuration {
            display-drun: "Applications";
            display-window: "drun";
            drun-display-format: "{name}";
            font: "Fira Sans SemiBold 11";
            modi: "run,drun";
            /* show-icons: true; */
        }

        window {
            width:700px;
        }

        element {
            padding:6;
        }

        element-text selected {
            text-color:#${config.colorScheme.colors.base00};
        }

        prompt {
            text-color:#${config.colorScheme.colors.base0F};
        }

        entry {
            text-color:#${config.colorScheme.colors.base0A};
        }

        /* vim: ft=sass
        '';

      ".cache/nix-colors/colors.py".text = ''
        #!/usr/bin/env python3

        colors = {
            "00": "${config.colorScheme.colors.base00}",
            "01": "${config.colorScheme.colors.base01}",
            "02": "${config.colorScheme.colors.base02}",
            "03": "${config.colorScheme.colors.base03}",
            "04": "${config.colorScheme.colors.base04}",
            "05": "${config.colorScheme.colors.base05}",
            "06": "${config.colorScheme.colors.base06}",
            "07": "${config.colorScheme.colors.base07}",
            "08": "${config.colorScheme.colors.base08}",
            "09": "${config.colorScheme.colors.base09}",
            "10": "${config.colorScheme.colors.base0A}",
            "11": "${config.colorScheme.colors.base0B}",
            "12": "${config.colorScheme.colors.base0C}",
            "13": "${config.colorScheme.colors.base0D}",
            "14": "${config.colorScheme.colors.base0E}",
            "15": "${config.colorScheme.colors.base0F}"
        }'';

      ".cache/nix-colors/colors".text = ''
        #${config.colorScheme.colors.base00}
        #${config.colorScheme.colors.base01}
        #${config.colorScheme.colors.base02}
        #${config.colorScheme.colors.base03}
        #${config.colorScheme.colors.base04}
        #${config.colorScheme.colors.base05}
        #${config.colorScheme.colors.base06}
        #${config.colorScheme.colors.base07}
        #${config.colorScheme.colors.base08}
        #${config.colorScheme.colors.base09}
        #${config.colorScheme.colors.base0A}
        #${config.colorScheme.colors.base0B}
        #${config.colorScheme.colors.base0C}
        #${config.colorScheme.colors.base0D}
        #${config.colorScheme.colors.base0E}
        #${config.colorScheme.colors.base0F}
        '';

      ".cache/nix-colors/colors-hyprland.conf".text = ''
$background = rgb(${config.colorScheme.colors.base00})
$foreground = rgb(${config.colorScheme.colors.base00})
$color0 = rgb(${config.colorScheme.colors.base00})
$color1 = rgb(${config.colorScheme.colors.base01})
$color2 = rgb(${config.colorScheme.colors.base02})
$color3 = rgb(${config.colorScheme.colors.base03})
$color4 = rgb(${config.colorScheme.colors.base04})
$color5 = rgb(${config.colorScheme.colors.base05})
$color6 = rgb(${config.colorScheme.colors.base06})
$color7 = rgb(${config.colorScheme.colors.base07})
$color8 = rgb(${config.colorScheme.colors.base08})
$color9 = rgb(${config.colorScheme.colors.base09})
$color10 = rgb(${config.colorScheme.colors.base0A})
$color11 = rgb(${config.colorScheme.colors.base0B})
$color12 = rgb(${config.colorScheme.colors.base0C})
$color13 = rgb(${config.colorScheme.colors.base0D})
$color14 = rgb(${config.colorScheme.colors.base0E})
$color15 = rgb(${config.colorScheme.colors.base0F})
        '';

      ".cache/nix-colors/colors-waybar.css".text = ''
@define-color foreground #${config.colorScheme.colors.base00};
@define-color background #${config.colorScheme.colors.base00};
@define-color cursor #${config.colorScheme.colors.base0F};

@define-color color0 #${config.colorScheme.colors.base00};
@define-color color1 #${config.colorScheme.colors.base01};
@define-color color2 #${config.colorScheme.colors.base02};
@define-color color3 #${config.colorScheme.colors.base03};
@define-color color4 #${config.colorScheme.colors.base04};
@define-color color5 #${config.colorScheme.colors.base05};
@define-color color6 #${config.colorScheme.colors.base06};
@define-color color7 #${config.colorScheme.colors.base07};
@define-color color8 #${config.colorScheme.colors.base08};
@define-color color9 #${config.colorScheme.colors.base09};
@define-color color10 #${config.colorScheme.colors.base0A};
@define-color color11 #${config.colorScheme.colors.base0B};
@define-color color12 #${config.colorScheme.colors.base0C};
@define-color color13 #${config.colorScheme.colors.base0D};
@define-color color14 #${config.colorScheme.colors.base0E};
@define-color color15 #${config.colorScheme.colors.base0F};
        '';

      ".cache/nix-colors/colors-wlogout.css".text = ''
@define-color foreground #${config.colorScheme.colors.base00};
@define-color background #${config.colorScheme.colors.base00};
@define-color cursor #${config.colorScheme.colors.base0F};

@define-color color0 #${config.colorScheme.colors.base00};
@define-color color1 #${config.colorScheme.colors.base01};
@define-color color2 #${config.colorScheme.colors.base02};
@define-color color3 #${config.colorScheme.colors.base03};
@define-color color4 #${config.colorScheme.colors.base04};
@define-color color5 #${config.colorScheme.colors.base05};
@define-color color6 #${config.colorScheme.colors.base06};
@define-color color7 #${config.colorScheme.colors.base07};
@define-color color8 #${config.colorScheme.colors.base08};
@define-color color9 #${config.colorScheme.colors.base09};
@define-color color10 #${config.colorScheme.colors.base0A};
@define-color color11 #${config.colorScheme.colors.base0B};
@define-color color12 #${config.colorScheme.colors.base0C};
@define-color color13 #${config.colorScheme.colors.base0D};
@define-color color14 #${config.colorScheme.colors.base0E};
@define-color color15 #${config.colorScheme.colors.base0F};
        '';

    };

    # You can also manage environment variables but you will have to manually
    # source
    #
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  /etc/profiles/per-user/keith/etc/profile.d/hm-session-vars.sh
    #
    # if you don't want to manage your shell through Home Manager.

    sessionVariables = {
      EDITOR = "nvim";
      TERMINAL = "kitty";
      TERMINAL_PROG = "kitty";
      BROWSER = "firedragon";

      # ~/ Clean-up:
      XDG_CONFIG_HOME="$HOME/.config";
      XDG_DATA_HOME="$HOME/.local/share";
      XDG_CACHE_HOME="$HOME/.cache";
      XINITRC="$XDG_CONFIG_HOME/x11/xinitrc";
      #XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"; # This line will break some DMs.
      NOTMUCH_CONFIG="$XDG_CONFIG_HOME/notmuch-config";
      # GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0";
      WGETRC="$XDG_CONFIG_HOME/wget/wgetrc";
      INPUTRC="$XDG_CONFIG_HOME/shell/inputrc";
      ZDOTDIR="$XDG_CONFIG_HOME/zsh";
      GNUPGHOME="$XDG_DATA_HOME/gnupg";
      WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default";
      KODI_DATA="$XDG_DATA_HOME/kodi";
      PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store";
      TMUX_TMPDIR="$XDG_RUNTIME_DIR";
      ANDROID_SDK_HOME="$XDG_CONFIG_HOME/android";
      CARGO_HOME="$XDG_DATA_HOME/cargo";
      GOPATH="$XDG_DATA_HOME/go";
      GOMODCACHE="$XDG_CACHE_HOME/go/mod";
      ANSIBLE_CONFIG="$XDG_CONFIG_HOME/ansible/ansible.cfg";
      UNISON="$XDG_DATA_HOME/unison";
      HISTFILE="$XDG_DATA_HOME/history";
      MBSYNCRC="$XDG_CONFIG_HOME/mbsync/config";
      ELECTRUMDIR="$XDG_DATA_HOME/electrum";
      PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc";
      SQLITE_HISTORY="$XDG_DATA_HOME/sqlite_history";

      # Other program settings:
      # DICS="/usr/share/stardict/dic/";
      # SUDO_ASKPASS="$HOME/.local/bin/dmenupass";
      # FZF_DEFAULT_OPTS="--layout=reverse --height 40%";
      # LESS=-R;
      # LESS_TERMCAP_mb="$(printf '%b' '[1;31m')";
      # LESS_TERMCAP_md="$(printf '%b' '[1;36m')";
      # LESS_TERMCAP_me="$(printf '%b' '[0m')";
      # LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')";
      # LESS_TERMCAP_se="$(printf '%b' '[0m')";
      # LESS_TERMCAP_us="$(printf '%b' '[1;32m')";
      # LESS_TERMCAP_ue="$(printf '%b' '[0m')";
      # LESSOPEN="| /usr/bin/highlight -O ansi %s 2>/dev/null";
      # QT_QPA_PLATFORMTHEME="gtk2"; # Have QT use gtk2 theme.
      # MOZ_USE_XINPUT2="1"; # Mozilla smooth scrolling/touchpads.
      # AWT_TOOLKIT="MToolkit wmname LG3D"; # May have to install wmname
      # _JAVA_AWT_WM_NONREPARENTING=1; # Fix for Java applications in dwm
    };

  };

# wayland.windowManager.hyprland.enable = true;
# wayland.windowManager.hyprland.systemdIntegration = true;
# wayland.windowManager.hyprland.xwayland.enable = true;

  programs.ssh = {
    enable = true;
    matchBlocks."github.com" = {
      user = "git";
      identityFile = "~/.ssh/id_ed25519";
    };
    extraConfig = ''
    '';
  };

programs.fzf = {
  package = pkgs.fzf;
  enable = true;
  enableFishIntegration = true;
  enableBashIntegration = true;
};

programs.starship = {
  enable = true;
  enableFishIntegration = true;
  enableBashIntegration = true;
  enableTransience = true;
};

programs.ncmpcpp = {
  enable = true;
  #mpdMusicDir= "~/Music";
  bindings = [
    { key = "j"; command = "scroll_down"; }
    { key = "k"; command = "scroll_up"; }
    { key = "J"; command = [ "select_item" "scroll_down" ]; }
    { key = "K"; command = [ "select_item" "scroll_up" ]; }
    { key = "v"; command = "show_visualizer"; }
  ];
};

programs.java.enable = true;

programs.direnv = {
  enable = true;
  nix-direnv.enable = true;
};

programs.borgmatic = {
  enable = true;
  backups = {
    personal = {
      location = {
        sourceDirectories = [config.home.homeDirectory];
        repositories = [ "/run/media/keith/4TB-BACKUP/backup" ];
        excludeHomeManagerSymlinks = true;
        # extraConfig = {
          # before_backup = "${pkgs.util-linux}/bin/findmnt /run/media/keith/4TB-BACKUP > /dev/null || exit 75";
        # };
      };
      consistency.checks = [
        {
            name = "repository";
            frequency = "2 weeks";
        }
        {
            name = "archives";
            frequency = "4 weeks";
        }
        {
            name = "data";
            frequency = "6 weeks";
        }
        {
            name = "extract";
            frequency = "6 weeks";
        }
      ];
      retention.keepWeekly = 3;
      # storage.encryptionPasscommand = "${pkgs.password-store}/bin/pass Root/borg-repo"
    };
  };
};

services.borgmatic = {
  enable = true;
  frequency = "weekly";
};

  services.mpd = {
    enable = true;
    musicDirectory = "~/Music";
  };

  services.syncthing.enable = true;
  services.syncthing.tray.enable = true;

  #services.mullvad-vpn.enable = true;

  #services.gvfs.enable = true; # Mount, trash, and other functionalities
  #services.tumbler.enable = true; # Thumbnail support for images

  services.home-manager.autoUpgrade.frequency = "weekly";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
