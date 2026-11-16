{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Allow unfree packages

  # List packages installed in system profile. To search, run:
  # $ nix search wget
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
    figma-linux
    alejandra
    (lutris.override {
        extraLibraries = pkgs : [];
        extraPkgs = pkgs:[];
    })
  ];
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };
}
