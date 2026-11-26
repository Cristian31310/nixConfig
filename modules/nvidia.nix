{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  options = {
    nvidia = {
      enable = lib.mkEnableOption "Enable nvidia graphic";
      open = lib.mkEnableOption "Change to open drivers";
      enableOffload = lib.mkEnableOption "Enables use iGPU for default and GPU for specifics programs";
      enablePManagment = lib.mkEnableOption "Enables graphic power managment";
      branch = lib.mkOption {
        # type = lib.types.string;
        default = "legacy_580";
        description = "Change branch driver";
      };
    };
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
        open = config.nvidia.open;
        powerManagement.enable = config.nvidia.enablePManagment;
        # branch = ${config.nvidia.branch};
        branch = config.nvidia.branch;
        prime = {
          offload = {
            enable = config.nvidia.enableOffload;
            enableOffloadCmd = config.nvidia.enableOffload;
          };
          intelBusId = "PCI:0:2:0";
          nvidiaBusId = "PCI:1:0:0";
        };
      };
    };
  };
}
