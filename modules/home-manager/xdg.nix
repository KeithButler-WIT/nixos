{ config, home-manager, userSettings, ... }:
{
  ### A tidy $HOME is a tidy mind
  xdg.enable = true;

  home = {
    sessionVariables = {
      # These are the defaults, and xdg.enable does set them, but due to load
      # order, they're not set before environment.variables are set, which could
      # cause race conditions.
      # XDG_CACHE_HOME = "$HOME/.cache";
      # XDG_CONFIG_HOME = "$HOME/.config";
      # XDG_DATA_HOME = "$HOME/.local/share";
      XDG_BIN_HOME = "$HOME/.local/bin";
      # XINITRC = "$XDG_CONFIG_HOME/x11/xinitrc";
      # XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"; # This line will break some DMs.

      # Conform more programs to XDG conventions. The rest are handled by their
      # respective modules.
      __GL_SHADER_DISK_CACHE_PATH = "$XDG_CACHE_HOME/nv";
      ASPELL_CONF = ''
        per-conf $XDG_CONFIG_HOME/aspell/aspell.conf;
        personal $XDG_CONFIG_HOME/aspell/en_US.pws;
        repl $XDG_CONFIG_HOME/aspell/en.prepl;
      '';
      CUDA_CACHE_PATH = "$XDG_CACHE_HOME/nv";
      HISTFILE = "$XDG_DATA_HOME/bash/history";
      INPUTRC = "$XDG_CONFIG_HOME/readline/inputrc";
      LESSHISTFILE = "$XDG_CACHE_HOME/lesshst";
      WGETRC = "$XDG_CONFIG_HOME/wgetrc";

      # Tools I don't use
      # SUBVERSION_HOME = "$XDG_CONFIG_HOME/subversion";
      # BZRPATH         = "$XDG_CONFIG_HOME/bazaar";
      # BZR_PLUGIN_PATH = "$XDG_DATA_HOME/bazaar";
      # BZR_HOME        = "$XDG_CACHE_HOME/bazaar";
      # ICEAUTHORITY    = "$XDG_CACHE_HOME/ICEauthority";

      NOTMUCH_CONFIG = "$XDG_CONFIG_HOME/notmuch-config";
      # GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0";
      ZDOTDIR = "$XDG_CONFIG_HOME/zsh";
      GNUPGHOME = "$XDG_DATA_HOME/gnupg";
      WINEPREFIX = "$XDG_DATA_HOME/wineprefixes/default";
      KODI_DATA = "$XDG_DATA_HOME/kodi";
      PASSWORD_STORE_DIR = "$XDG_DATA_HOME/password-store";
      #TMUX_TMPDIR = "$XDG_RUNTIME_DIR";
      ANDROID_SDK_HOME = "$XDG_CONFIG_HOME/android";
      ANDROID_HOME = "$XDG_CONFIG_HOME/android";
      CARGO_HOME = "$XDG_DATA_HOME/cargo";
      GOPATH = "$XDG_DATA_HOME/go";
      GOMODCACHE = "$XDG_CACHE_HOME/go/mod";
      ANSIBLE_CONFIG = "$XDG_CONFIG_HOME/ansible/ansible.cfg";
      UNISON = "$XDG_DATA_HOME/unison";
      MBSYNCRC = "$XDG_CONFIG_HOME/mbsync/config";
      ELECTRUMDIR = "$XDG_DATA_HOME/electrum";
      PYTHONSTARTUP = "$XDG_CONFIG_HOME/python/pythonrc";
      SQLITE_HISTORY = "$XDG_DATA_HOME/sqlite_history";
    };
    # Move ~/.Xauthority out of $HOME (setting XAUTHORITY early isn't enough)
    # extraInit = ''
    #   export XAUTHORITY=/tmp/Xauthority
    #   [ -e ~/.Xauthority ] && mv -f ~/.Xauthority "$XAUTHORITY"
    # '';
  };

}
