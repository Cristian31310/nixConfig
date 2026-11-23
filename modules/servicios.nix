{
  config,
  pkgs,
  inputs,
  ...
}: {
  services = {
    xserver = {
      xkb = {
        layout = "es";
        variant = "dvorak";
      };

      videoDrivers = ["nvidia"];
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
}
