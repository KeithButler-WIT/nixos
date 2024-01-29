{ config, pkgs, lib, inputs, ... }:

{

  services.xserver.videoDrivers = [ "amdgpu" ];

}
