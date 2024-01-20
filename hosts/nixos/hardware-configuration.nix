# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/487106e6-1c6d-48fc-9b42-4ed75085bce6";
      fsType = "ext4";
    };

  boot.zfs.forceImportRoot = false;
  boot.supportedFilesystems = [ "zfs" ];
  boot.initrd.luks.devices."luks-d653e092-1b1c-4f91-8b7d-d82f2cf4be28".device = "/dev/disk/by-uuid/d653e092-1b1c-4f91-8b7d-d82f2cf4be28";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/0D5D-3591";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/e0f083ce-a92f-4533-a2b8-94af1beb7a30"; }
    ];

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
