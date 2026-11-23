{
  inputs,
  lib,
  config,
  ...
}: {
  imports = [
    ./apps.nix
    ./programs.nix
    ./security.nix
    ./servicios.nix
    ./themes.nix
    ./nvidia.nix
  ];
  
  nvidia.enable = true;
}
