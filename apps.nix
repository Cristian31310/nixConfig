{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Allow unfree packages

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  programs.k3b.enable = true;
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    neovim
    git
    btop
    tmux
    kitty
    waybar
    fastfetch
    firefox
    eza
    gcc
    awww
    udiskie
    dunst
    obsidian
    nodejs
    lemurs
    pavucontrol
    wofi
    discord
    obsidian
    hyprshot
    vesktop
    bluetui
    polkit_gnome
    live-server
    unzip
    vlc
    libdvdcss
    # okular
    # nerdfonts
    # spotify
    # okular
    # virtualbox
    # oracle-ex
    # mysql
    zoxide
    inputs.zen-browser.packages."${pkgs.system}".default
    inputs.firefox.packages.${pkgs.stdenv.hostPlatform.system}.firefox-nightly-bin
    figma-linux
    alejandra
    (lutris.override {
        extraLibraries = pkgs : [];
        extraPkgs = pkgs:[];
    })
    kdePackages. dolphin
    kdePackages.kio # needed since 25.11
    kdePackages.kio-fuse #to mount remote filesystems via FUSE
    kdePackages.kio-extras #extra protocols support (sftp, fish and more)
    unrar
  ];
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };
}
