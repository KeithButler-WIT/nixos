{
  config,
  lib,
  ...
}: {
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
    OpenGL_GL_PREFERENCE = "GLVND";
    ROC_ENABLE_PRE_VEGA = "1";
    GSK_RENDERER = "ngl";

    # Other program settings:
    _ZO_RESOLVE_SYMLINKS = "1";
    # FZF_DEFAULT_OPTS = "--height=40% --layout=reverse --info=inline --border --margin=1 --padding=1";
    _JAVA_AWT_WM_NONREPARENTING = 1; # Fix for Java applications in dwm

    MANPAGER = "nvim +Man!";
    NIXOS_OZONE_WL = "1";
    __GL_GSYNC_ALLOWED = "0";
    __GL_VRR_ALLOWED = "0";
    _JAVA_AWT_WM_NONEREPARENTING = "1";
    SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
    DISABLE_QT5_COMPAT = "0";
    ANKI_WAYLAND = "1";
    DIRENV_LOG_FORMAT = "";
    WLR_DRM_NO_ATOMIC = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    MOZ_ENABLE_WAYLAND = "1";
    WLR_BACKEND = "vulkan";
    # WLR_RENDERER = "vulkan";
    WLR_NO_HARDWARE_CURSORS = "1";
    XDG_SESSION_TYPE = "wayland";
    GDK_BACKEND = "wayland,x11";
    SDL_VIDEODRIVER = "wayland,x11";
    CLUTTER_BACKEND = "wayland";
  };
}
