{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  options = {
    steam = {
      enable = lib.mkEnableOption "Enable Steam";
      enableGamesScope = lib.mkEnableOption "Help Scaling and Aspect ratios";
    };
  };

  config = lib.mkIf config.steam.enable {
    programs = {
      steam = {
        enable = true;
        remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
        localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
        gamescopeSession.enable = config.steam.enableGamesScope;
        package = pkgs.steam.override {
          withPrimus = true;
          extraPkgs = pkgs: [bumblebee glxinfo];
        };
      };
    };
  };
}
