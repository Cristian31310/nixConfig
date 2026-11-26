{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
let EDITOR = "nvim";
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/modules.nix
  ];

  nvidia.enable = true;
  nvidia.open = true;

  bluetooth.enable = true;

  users.users.eve.isNormalUser = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  systemd.settings.Manager = {
    DefaultLimitNOFILE = 524288;
  };

  networking.hostName = "ea-nasir"; # Define your hostname.
  virtualisation.virtualbox.host.enable = true;
  networking.useDHCP = lib.mkDefault true;
  services.openssh.enable = true;
  # Enable networking
  networking.networkmanager.enable = true;

  networking.firewall.allowedTCPPorts = [5501 8080 3307 80];
  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties.
  i18n.defaultLocale = "es_ES.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.eanasir = {
    isNormalUser = true;
    description = "ea-nasir";
    extraGroups = ["networkmanager" "wheel" "docker" "seat" "audio" "cdrom"];
    packages = with pkgs; [];
  };

  users.extraGroups.vboxusers.members = ["ea-nasir"];

  users.extraUsers.eanasir = {
    shell = pkgs.fish;
  };
  # Allow unfree packages

  virtualisation.docker = {
    enable = true;
  };

  nixpkgs.config.permittedInsecurePackages = [
    "pnpm-10.29.2"
  ];

  environment.variables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
    EDITOR = EDITOR;
    SUDO_EDITOR = EDITOR;
    SYSTEMD_EDITOR = EDITOR;
    VISUAL = EDITOR;
  };

  hardware.enableAllFirmware = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).

  system.stateVersion = "25.11"; # Did you read the comment?
}
