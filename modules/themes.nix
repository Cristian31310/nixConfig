{pkgs, ...}: {
  # Install themes and engines
  environment.systemPackages = with pkgs; [
    nordic
    papirus-icon-theme
    adwaita-qt
    adwaita-qt6
    catppuccin-gtk
  ];

  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
    GTK_THEME = "Adwaita-dark";
  };

  fonts.packages = with pkgs; [
    nerd-fonts.fantasque-sans-mono
  ];

  programs.dconf.enable = true;
}
