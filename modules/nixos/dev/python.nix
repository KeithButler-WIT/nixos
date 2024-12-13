{ pkgs, config, lib, userSettings, ... }:

with lib;
with lib.my;
let devCfg = config.modules.dev;
    cfg = devCfg.python;
in {

  options.modules.dev.python =  {
    enable = mkBoolOpt false;
    xdg.enable = mkBoolOpt devCfg.xdg.enable;
  };

config = mkMerge [
    (mkIf cfg.enable {
    users.users.${userSettings.username}.packages = with pkgs; [
      (python3.withPackages (ps: with ps; [ 
        types-beautifulsoup4 
        beautifulsoup4 
        wxpython
        requests
        nuitka
        loguru
      ]))
    ];

      environment.shellAliases = {
        py     = "python";
        py2    = "python2";
        py3    = "python3";
        po     = "poetry";
        ipy    = "ipython --no-banner";
        ipylab = "ipython --pylab=qt5 --no-banner";
      };
    })

    (mkIf cfg.xdg.enable {
      environment.variables = {
        # Internal
        PYTHONPYCACHEPREFIX = "$XDG_CACHE_HOME/python";
        PYTHONSTARTUP = "$XDG_CONFIG_HOME/python/pythonrc";
        PYTHONUSERBASE = "$XDG_DATA_HOME/python";
        PYTHON_EGG_CACHE = "$XDG_CACHE_HOME/python-eggs";
        PYTHONHISTFILE = "$XDG_DATA_HOME/python/python_history"; # default value as of >=3.4

        # Tools
        IPYTHONDIR = "$XDG_CONFIG_HOME/ipython";
        JUPYTER_CONFIG_DIR = "$XDG_CONFIG_HOME/jupyter";
        PIP_CONFIG_FILE = "$XDG_CONFIG_HOME/pip/pip.conf";
        PIP_LOG_FILE = "$XDG_STATE_HOME/pip/log";
        PYLINTHOME = "$XDG_DATA_HOME/pylint";
        PYLINTRC = "$XDG_CONFIG_HOME/pylint/pylintrc";
        WORKON_HOME = "$XDG_DATA_HOME/virtualenvs";
      };
    })
  ];

}
