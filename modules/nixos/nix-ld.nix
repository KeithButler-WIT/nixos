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
        libX11
        libXScrnSaver
        libXcomposite
        libXcursor
        libXdamage
        libXext
        libXfixes
        libXi
        libXrandr
        libXrender
        libXtst
        libxcb
        libxkbfile
        libxshmfence
        zlib

        openssl
        libXcomposite
        libXtst
        libXrandr
        libXext
        libX11
        libXfixes
        libGL
        libva
        libxcb
        libXdamage
        libxshmfence
        libXxf86vm
        libelf

        # Required
        glib
        glibc
        gtk2
        bzip2

        # Without these it silently fails
        libXinerama
        libXcursor
        libXrender
        libXScrnSaver
        libXi
        libSM
        libICE
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
        libXt
        libXmu
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
        libXft
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

        libX11
        libXcomposite
        libXdamage
        libXext
        libXfixes
        libXrandr
        libxcb

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
