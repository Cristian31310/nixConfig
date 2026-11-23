{
  inputs,
  lib,
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
}
