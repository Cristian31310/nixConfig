{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:{

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
    yazi = {
      enable = true;
      # Aquí puedes definir tu configuración
      plugins = {
        inherit (pkgs.yaziPlugins) mount;
      };
      settings = {
        keymap = lib.importTOML ./yazi/keymap.toml;
      };
    };

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

    niri.enable = true;
  };

}
