{ config, lib, pkgs, ... }:

{
  # home.sessionPath = [
  #       "$HOME/.local/bin"
  #       "\${xdg.configHome}/emacs/bin"
  # ];

  home.sessionVariables = {
    EDITOR = "nvim";
    ALTERNATE_EDITOR = "nvim";
    TERMINAL = "kitty";
    TERMINAL_PROG = "kitty";
    BROWSER = "floorp";
    MAIL = "thunderbird";


    # ~/ Clean-up:
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_CACHE_HOME = "$HOME/.cache";
    XINITRC = "$XDG_CONFIG_HOME/x11/xinitrc";
    #XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"; # This line will break some DMs.
    NOTMUCH_CONFIG = "$XDG_CONFIG_HOME/notmuch-config";
    # GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0";
    WGETRC = "$XDG_CONFIG_HOME/wget/wgetrc";
    INPUTRC = "$XDG_CONFIG_HOME/shell/inputrc";
    ZDOTDIR = "$XDG_CONFIG_HOME/zsh";
    GNUPGHOME = "$XDG_DATA_HOME/gnupg";
    WINEPREFIX = "$XDG_DATA_HOME/wineprefixes/default";
    KODI_DATA = "$XDG_DATA_HOME/kodi";
    PASSWORD_STORE_DIR = "$XDG_DATA_HOME/password-store";
    TMUX_TMPDIR = "$XDG_RUNTIME_DIR";
    ANDROID_SDK_HOME = "$XDG_CONFIG_HOME/android";
    ANDROID_HOME = "$XDG_CONFIG_HOME/android";
    CARGO_HOME = "$XDG_DATA_HOME/cargo";
    GOPATH = "$XDG_DATA_HOME/go";
    GOMODCACHE = "$XDG_CACHE_HOME/go/mod";
    ANSIBLE_CONFIG = "$XDG_CONFIG_HOME/ansible/ansible.cfg";
    UNISON = "$XDG_DATA_HOME/unison";
    HISTFILE = "$XDG_DATA_HOME/history";
    MBSYNCRC = "$XDG_CONFIG_HOME/mbsync/config";
    ELECTRUMDIR = "$XDG_DATA_HOME/electrum";
    PYTHONSTARTUP = "$XDG_CONFIG_HOME/python/pythonrc";
    SQLITE_HISTORY = "$XDG_DATA_HOME/sqlite_history";
    OpenGL_GL_PREFERENCE = "GLVND";
    ROC_ENABLE_PRE_VEGA = "1";

    # Other program settings:
    QT_QPA_PLATFORMTHEME = "qt5ct";
    XDG_CURRENT_DESKTOP = "Unity";
    # DICS="/usr/share/stardict/dic/";
    # SUDO_ASKPASS="$HOME/.local/bin/dmenupass";
    FZF_DEFAULT_OPTS = "--height=40% --layout=reverse --info=inline --border --margin=1 --padding=1";
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
  };

}
