{
  pkgs,
  config,
  lib,
  ...
}:

with lib;
with lib.my;
let
  cfg = config.modules.tmux;
in
{

  options.modules.tmux.enable = mkBoolOpt false;

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      sensibleOnTop = true;
      shell = "${pkgs.fish}/bin/fish";
      keyMode = "vi";
      mouse = true;
      plugins = with pkgs; [
        tmuxPlugins.cpu
        {
          plugin = tmuxPlugins.continuum;
          extraConfig = ''
            set -g @continuum-restore 'on'
            set -g @continuum-save-interval '60' # minutes
          '';
        }
      ];
    };
  };

}
