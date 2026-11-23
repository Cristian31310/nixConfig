{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  options = {
    nvidia.enable = lib.mkEnableOption "enable nvidia";
    nvidia.open = lib.mkEnableOption "enables nvidia open drivers";
    nvidia.enableOffload = lib.mkEnableOption "enables offload";
    nvidia.enablePManagment = lib.mkEnableOption "enables graphic power managment";
  };
  
  config = lib.mkIf config.nvidia.enable {
    services.xserver.videoDrivers = ["nvidia"];

    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };

      nvidia = {
        modesetting.enable = true;
        open = false;
        powerManagement.enable = false;
        branch = "legacy_580";
        prime = {
          offload = {
            enable = false;
            enableOffloadCmd = false;
          };
          intelBusId = "PCI:0:2:0";
          nvidiaBusId = "PCI:1:0:0";
        };
      };
    };
  };
}
