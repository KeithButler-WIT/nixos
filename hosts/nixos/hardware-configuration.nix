# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usbhid" "usb_storage" "sd_mod" ];
  boot.kernelModules = [ "kvm-amd" "v4l2loopback" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';

  # boot = {
  #   # booting with zfs
  #   supportedFilesystems = [ "zfs" ];
  #   # kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  #   zfs = {
  #     devNodes = lib.mkDefault "/dev/disk/by-id";
  #     package = pkgs.zfs_unstable;
  #     # requestEncryptionCredentials = cfg.encryption;
  #   };
  # };

  # standardized filesystem layout
  # fileSystems = {
  #   # boot partition
  #   "/boot" = {
  #     device = "/dev/disk/by-label/NIXBOOT";
  #     fsType = "vfat";
  #   };

  #   # zfs datasets
  #   "/" = {
  #     device = "zroot/root";
  #     fsType = "zfs";
  #     neededForBoot = true;
  #     # neededForBoot = !persistCfg.tmpfs;
  #   };

  #   "/nix" = {
  #     device = "zroot/nix";
  #     fsType = "zfs";
  #   };

  #   "/tmp" = {
  #     device = "zroot/tmp";
  #     fsType = "zfs";
  #   };

  #   "/persist" = {
  #     device = "zroot/persist";
  #     fsType = "zfs";
  #     neededForBoot = true;
  #   };

  #   "/persist/cache" = {
  #     device = "zroot/cache";
  #     fsType = "zfs";
  #     neededForBoot = true;
  #   };
  # };

  # systemd.services.systemd-udev-settle.enable = false;

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/487106e6-1c6d-48fc-9b42-4ed75085bce6";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/0D5D-3591";
      fsType = "vfat";
    };
  };

  boot.initrd.luks.devices."luks-d653e092-1b1c-4f91-8b7d-d82f2cf4be28".device = "/dev/disk/by-uuid/d653e092-1b1c-4f91-8b7d-d82f2cf4be28";

  # 16GB swap
  # swapDevices = [{ device = "/dev/disk/by-label/SWAP"; }];
  swapDevices =
    [{ device = "/dev/disk/by-uuid/e0f083ce-a92f-4533-a2b8-94af1beb7a30"; }];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp4s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
