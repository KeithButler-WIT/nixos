{ pkgs, config, lib, ... }:

{

  options = {
    power-management.enable =
      lib.mkEnableOption "enables power-management";
  };

  config = lib.mkIf config.power-management.enable {
    # https://nixos.wiki/wiki/Power_Management
    # https://nixos.wiki/wiki/Laptop

    # powerManagement.enable = true;
    # powerManagement.powertop.enable = true;

    services.tlp = {
      enable = true;
      settings = {
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;

        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 50;

        #Optional helps save long term battery health
        START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
        STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging

        USB_AUTOSUSPEND = 0;
      };
    };

    # Disable KDE and GNOMEs power management
    services.power-profiles-daemon.enable = false;

    # Better scheduling for CPU cycles
    services.system76-scheduler.enable = true;
    services.system76-scheduler.settings.cfsProfiles.enable = true;

    # services.auto-cpufreq.enable = true;
    # services.auto-cpufreq.settings = {
    #   battery = {
    #     governor = "powersave";
    #     turbo = "never";
    #   };
    #   charger = {
    #     governor = "performance";
    #     turbo = "auto";
    #   };
    # };
  };

}
