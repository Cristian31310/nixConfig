{pkgs, ...}: {
  # Install themes and engines
  environment.systemPackages = with pkgs; [
    # Themes & Icons
    nordic
    papirus-icon-theme
    adwaita-qt
    adwaita-qt6
    catppuccin-gtk

    # GUI tools to switch them imperatively
    nwg-look # GTK3/4 theme switcher (Wayland-friendly)
    lxappearance # GTK2/3 theme switcher (X11)
    libsForQt5.qt5ct
    kdePackages.qt6ct
    # libsForQt5.kvantum
  ];

  # Make Qt apps discover themes and use qt5ct/qt6ct or gtk
  environment.sessionVariables = {
    # Options: "gtk2", "qt5ct", or "gnome"
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };

  # Required for dconf settings (used by GTK)
  programs.dconf.enable = true;
}
