{ config, lib, pkgs, userSettings, ... }:

{
  # home.sessionPath = [
  #       "$HOME/.local/bin"
  #       "\${xdg.configHome}/emacs/bin"
  # ];

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/${userSettings.username}/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = userSettings.editor;
    ALTERNATE_EDITOR = userSettings.alternateEditor;
    TERMINAL = userSettings.term;
    TERMINAL_PROG = userSettings.term;
    BROWSER = userSettings.browser;
    MAIL = userSettings.mail;

    OpenGL_GL_PREFERENCE = "GLVND";
    ROC_ENABLE_PRE_VEGA = "1";

    # Other program settings:
    # QT_QPA_PLATFORMTHEME = "qt5ct";
    # XDG_CURRENT_DESKTOP = "Unity";
    _ZO_RESOLVE_SYMLINKS = "1";
    # DICS="/usr/share/stardict/dic/";
    # SUDO_ASKPASS="$HOME/.local/bin/dmenupass";
    # FZF_DEFAULT_OPTS = "--height=40% --layout=reverse --info=inline --border --margin=1 --padding=1";
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
    _JAVA_AWT_WM_NONREPARENTING = 1; # Fix for Java applications in dwm

    NIXOS_OZONE_WL = "1";
    __GL_GSYNC_ALLOWED = "0";
    __GL_VRR_ALLOWED = "0";
    _JAVA_AWT_WM_NONEREPARENTING = "1";
    SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
    DISABLE_QT5_COMPAT = "0";
    GDK_BACKEND = "wayland";
    ANKI_WAYLAND = "1";
    DIRENV_LOG_FORMAT = "";
    WLR_DRM_NO_ATOMIC = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_QPA_PLATFORM = "xcb";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_STYLE_OVERRIDE = "kvantum";
    MOZ_ENABLE_WAYLAND = "1";
    WLR_BACKEND = "vulkan";
    # WLR_RENDERER = "vulkan";
    WLR_NO_HARDWARE_CURSORS = "1";
    # XDG_SESSION_TYPE = "wayland";
    # SDL_VIDEODRIVER = "wayland";
    # CLUTTER_BACKEND = "wayland";

  };

}
