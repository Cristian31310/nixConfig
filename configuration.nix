{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./apps.nix
  ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  systemd.settings.Manager = {
    DefaultLimitNOFILE = 524288;
  };
  security.pam.loginLimits = [
    {
      domain = "yourusername";
      type = "hard";
      item = "nofile";
      value = "524288";
    }
  ];
  networking.hostName = "nixos"; # Define your hostname.
  virtualisation.virtualbox.host.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties.
  i18n.defaultLocale = "es_ES.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    # ./apps.nix
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };
  hardware.enableAllFirmware = true;

  # Configure keymap in X11
  services = {
    xserver = {
      xkb = {
        layout = "es";
        variant = "dvorak";
      };
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
      jack.enable = true;
    };

    pulseaudio.enable = false; # Use Pipewire, the modern sound subsystem
    udisks2.enable = true;

    flatpak.enable = true;

    displayManager.lemurs.enable = true;

    udev.enable = true;
    udev.extraRules = ''
      # Optical Drive access for K3b
      KERNEL=="sr[0-9]*", GROUP="cdrom", MODE="0660"
    '';

    blueman.enable = true;
  };

  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        action.id == "org.freedesktop.login1.reboot" ||
        action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
        action.id == "org.freedesktop.login1.power-off" ||
        action.id == "org.freedesktop.login1.power-off-multiple-sessions" ||

        action.id == "org.freedesktop.udisks2.filesystem-mount" ||
        action.id == "org.freedesktop.udisks2.filesystem-mount-system" ||
        action.id == "org.freedesktop.udisks2.filesystem-mount-other-seat"

      ) {
        // Allow users in the 'wheel' group to shutdown/reboot without password
        if (subject.isInGroup("wheel")) {
          return polkit.Result.YES;
        }
      }
      });
  '';
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.eanasir = {
    isNormalUser = true;
    description = "ea-nasir";
    extraGroups = ["networkmanager" "wheel" "docker" "seat" "audio" "cdrom"];
    packages = with pkgs; [];
  };
  users.extraGroups.vboxusers.members = ["ea-nasir"];
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  virtualisation.docker = {
    enable = true;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.fantasque-sans-mono
  ];
  nixpkgs.config.permittedInsecurePackages = [
    "pnpm-10.29.2"
  ];
  # nixpkgs.config.permittedInsecurePackages = [
  #  "pnpm-10.29.2"
  # ];
  environment.variables = {
    GTK_THEME = "Adwaita-dark";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
    EDITOR = "nvim";
    SUDO_EDITOR = "nvim";
    SYSTEMD_EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # Set Display Manager

  # Install Hyprland and enable wayland and UWSM
  programs = {
    zoxide = {
      enable = true;
      enableBashIntegration = true;
    };
    hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };
    fish = {
      enable = true;
      interactiveShellInit = ''set -g fish_greeting "" '';
      shellAliases = {
        cd = "z";
      };
    };
    steam = {
      enable = true;
    };
    gamemode.enable = true;
    nix-ld.enable = true;
    # yazi = {
    #   enable = true;
    #   # Aquí puedes definir tu configuración
    #   plugins = {
    #     inherit (pkgs.yaziPlugins) mount;
    #   };
    #   settings = {
    #     keymap = lib.importTOML ./yazi/keymap.toml;
    #   };
    # };

    git = {
      enable = true;
      config = {
        user = {
          name = "Cristian31310";
          email = "cristian.martin.almendros@gmail.com";
        };
        init.defaultBranch = "main";
      };
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      viAlias = true;
    };
  };

  # hardware.graphics.enable = true;
  # services.xserver.videoDrivers = [ "nvidia" ];
  # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_580;

  users.extraUsers.eanasir = {
    shell = pkgs.fish;
  };
  # Enable audio
  security.rtkit.enable = true; # Enable RealtimeKit for audio purposes

  # sound.enable = true;
  # Pulse audio
  hardware = {

    bluetooth = {
      enable = true;
      powerOnBoot = true;

      settings = {
        General = {
          Experimental = true;
          FastConnectable = true;
        };

        Policy = {
          AutoEnable = true;
        };
      };
    };
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [5501 8080 3307];
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
  # stdenv.hostPlatform.system.stateVersion = "25.11"; # Did you read the comment?
}
