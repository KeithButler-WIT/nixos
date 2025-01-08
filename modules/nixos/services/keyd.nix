{
  config,
  lib,
  userSettings,
  ...
}:
with lib;
with lib.my;
let
  cfg = config.modules.services.keyd;
in
{
  options.modules.services.keyd.enable = mkBoolOpt false;

  config = mkIf cfg.enable {
    users.users.${userSettings.username}.extraGroups = [ "keyd" ];
    services.keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = [ "*" ];
          settings = {
            main = {
              capslock = "overload(esc, capslock)";
              esc = "overload(esc, capslock)";
            };
          };
        };
      };
    };
  };
}
