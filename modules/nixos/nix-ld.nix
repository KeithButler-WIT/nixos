{
  pkgs,
  pkgs-stable,
  config,
  lib,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.nix-ld;
in {
  options.modules.nix-ld.enable = mkBoolOpt false;

  config = lib.mkIf cfg.enable {
    programs.nix-ld = {
      enable = true;
      # Sets up all the libraries to load
      libraries = with pkgs; [
        alsa-lib
        at-spi2-atk
        at-spi2-core
        atk
        cairo
        cups
        curl
        dbus
        expat
        fontconfig
        freetype
        fuse3
        gdk-pixbuf
        gtk3
        icu

        fuse

        libgbm
        libz
        zstd
        gss
        krb5
        libatomic_ops
        nss

        libxkbcommon

        loguru
        # libdl
        # libm
        # libpython3
        # libc

        libGLU
        ncurses6
        harfbuzz

        # tes3mp
        luajit
        boost

        gss

        libGL
        libappindicator-gtk3
        libdrm
        libglvnd
        libnotify
        libpulseaudio
        libunwind
        libusb1
        libuuid
        libxkbcommon
        libxml2
        mesa
        nspr
        nss
        openssl
        pango
        pipewire
        stdenv.cc.cc
        stdenv.cc.cc.lib
        #pkgs-stable.libstdcxx5
        systemd
        vulkan-loader
        xorg.libX11
        xorg.libXScrnSaver
        xorg.libXcomposite
        xorg.libXcursor
        xorg.libXdamage
        xorg.libXext
        xorg.libXfixes
        xorg.libXi
        xorg.libXrandr
        xorg.libXrender
        xorg.libXtst
        xorg.libxcb
        xorg.libxkbfile
        xorg.libxshmfence
        zlib

        openssl
        xorg.libXcomposite
        xorg.libXtst
        xorg.libXrandr
        xorg.libXext
        xorg.libX11
        xorg.libXfixes
        libGL
        libva
        xorg.libxcb
        xorg.libXdamage
        xorg.libxshmfence
        xorg.libXxf86vm
        libelf

        # Required
        glib
        glibc
        gtk2
        bzip2

        # Without these it silently fails
        xorg.libXinerama
        xorg.libXcursor
        xorg.libXrender
        xorg.libXScrnSaver
        xorg.libXi
        xorg.libSM
        xorg.libICE
        # TODO: uncomment when builds
        #gnome2.GConf
        #gnome2.ORBit2
        nspr
        nss
        cups
        libcap
        # SDL2
        libusb1
        dbus-glib
        gcc
        ffmpeg
        # Only libraries are needed from those two
        libudev0-shim

        # Verified games requirements
        xorg.libXt
        xorg.libXmu
        libogg
        #libvorbis
        SDL
        SDL2_image
        glew_1_10
        libidn
        tbb
        nss

        # Other things from runtime
        flac
        freeglut
        libjpeg
        libpng
        libpng12
        libsamplerate
        libmikmod
        libtheora
        libtiff
        pixman
        speex
        # SDL_image
        # SDL_ttf
        # SDL_mixer
        # SDL2_ttf
        # SDL2_mixer
        libappindicator-gtk2
        libdbusmenu-gtk2
        libindicator-gtk2
        libcaca
        libcanberra
        libgcrypt
        libvpx
        librsvg
        xorg.libXft
        libvdpau
        cairo
        atk
        gdk-pixbuf
        fontconfig
        freetype
        dbus
        expat

        libz
        icu
        openssl # For updater

        xorg.libX11
        xorg.libXcomposite
        xorg.libXdamage
        xorg.libXext
        xorg.libXfixes
        xorg.libXrandr
        xorg.libxcb

        gtk3
        glib
        nss
        nspr
        dbus
        atk
        cups
        libdrm
        expat
        libxkbcommon
        pango
        cairo
        udev
        alsa-lib
        libGL
        libsecret
      ];
    };
  };
}
