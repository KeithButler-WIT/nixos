{
  config,
  pkgs,
  userSettings,
  ...
}:

{

  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiInstallAsRemovable = true;
    efiSupport = true;
    useOSProber = true;
    zfsSupport = true;
  };
  # boot.loader.efistub = {
  #   enable = true;
  # }

  # empty out /tmp on boot
  boot.tmp.cleanOnBoot = true;
  #boot.tmp.useTmpfs = true;
  #boot.tmp.tmpfsSize = "25%";

  boot.kernelModules = [
    "kvm-amd"
    "v4l2loopback"
  ];
  boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';

  boot.kernelParams = [
    "nohibernate" # Needed for zfs
    "v4l2loopback"
    # "quiet"
    # "splash"
    "vga=current"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
  ];
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;

}
